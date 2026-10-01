# Architecture

## Project layout

```
lib/
├── main.dart                 # Entry point: loads tasks, wires persistence, runs app
├── app.dart                  # SchediumApp (MaterialApp + AppBar) and BackNavigation
├── schedium.dart             # Barrel: exports schedium.Widget and Navigation
├── schedium/
│   ├── widget.dart           # schedium.Widget: StatelessWidget that carries AppState
│   └── navigation.dart       # Navigation: signal-based screen history
├── model/
│   ├── model.dart            # Barrel: exports AppState and Task
│   ├── app_state.dart        # AppState: title, tasks, navigation, current screen
│   └── task/
│       ├── task.dart         # Task (+ JSON serialisation)
│       ├── state.dart        # State enum (undone / done / ignored)
│       └── task_service.dart # Load/save tasks via shared_preferences
└── ui/
    ├── theme/                # app_theme.dart, palette.dart
    ├── screens/              # home.dart, task.dart (+ screens.dart barrel)
    └── widgets/              # Reusable widgets (one widget per file)
        └── task/             # Task-specific widgets
```

## Startup (`main.dart`)

1. `TaskService.loadTasks()` reads saved tasks (an empty list if nothing is stored
   or the stored data is corrupt).
2. An `AppState` is created with the title `Schedium` and the loaded tasks.
3. An `effect()` subscribes to the tasks list and to every task's `title`,
   `description`, `state` and `isDeleted` signals. Whenever any of them change,
   `TaskService.saveTasks(tasks)` runs. This is the **only** place persistence
   is triggered; UI code never calls the service directly.
4. The `Home` screen is pushed onto the navigation history and `runApp` starts
   `SchediumApp`.

## Navigation

Schedium does not use Flutter's `Navigator` for screens. Instead:

- `AppState.navigation.history` is a `Signal<List<Widget>>`: a stack of screens.
- `AppState.currentScreen` is a `computed` that returns the last item of the stack.
- `SchediumApp` renders `currentScreen` inside a single `Scaffold` with an `AppBar`.
- **Push** a screen: `appState.navigation.history.add(screens.Task(appState, data: task))`
- **Pop** a screen: `appState.navigation.history.removeLast()`
- `BackNavigation` shows the back button only when the stack has two or more entries.

Dialogs and popup menus (e.g. the delete confirmation) still use Flutter's
overlay/`Navigator` via `showDialog` and `PopupMenuButton`; only *screens* go
through the custom history.

## Data flow

```
UI event ──► mutate a signal (task.title.value = ..., appState.tasks.add(...))
                │
                ├──► SignalBuilder widgets rebuild
                └──► effect() in main.dart ──► TaskService.saveTasks ──► SharedPreferences
```

State flows one way: widgets mutate signals, and everything else (rebuilds and
persistence) reacts to them.

## Widget base class

Screens and reusable components that need app-wide state extend `schedium.Widget`,
which is a `StatelessWidget` with an `appState` field. Purely presentational widgets
(for example `StateChip`, `TitleField`) extend `StatelessWidget` directly and receive
only what they need as constructor parameters.
