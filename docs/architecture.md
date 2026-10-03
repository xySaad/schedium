# Architecture

## Project layout

```
lib/
├── main.dart                 # Entry point: initializes database, loads tasks, runs app
├── app.dart                  # SchediumApp (MaterialApp + AppBar) and BackNavigation
├── schedium.dart             # Barrel: exports schedium.Widget and Navigation
├── schedium/
│   ├── widget.dart           # schedium.Widget: StatelessWidget that carries AppState
│   ├── navigation.dart       # Navigation: signal-based screen history
│   ├── persistent_item.dart  # PersistentItem: interface for database-synced models
│   └── persistent_list_signal.dart # PersistentListSignal: Signal list backed by Drift table
├── database/
│   ├── database.dart         # AppDatabase: Drift SQLite database definition & exports
│   └── tables/               # Table schemas (tasks_table.dart)
├── model/
│   ├── model.dart            # Barrel: exports AppState, Task, TaskState, PersistentTask
│   ├── app_state.dart        # AppState: title, tasks, navigation, current screen, nextId
│   └── task/
│       ├── task.dart         # Task model with reactive signal fields
│       ├── persistent_task.dart # PersistentTask: extends Task with Drift auto-syncing
│       ├── task_state.dart   # TaskState enum (undone / done / ignored)
│       └── task_service.dart # Database query service for tasks
└── ui/
    ├── theme/                # app_theme.dart, palette.dart
    ├── screens/              # home.dart, task.dart (+ screens.dart barrel)
    ├── dialogs/              # confirmation_dialog.dart
    └── widgets/              # Reusable widgets (one widget per file)
        └── task/             # Task-specific widgets
```

## Startup (`main.dart`)

1. `WidgetsFlutterBinding.ensureInitialized()` ensures Flutter engine bindings are initialized.
2. `AppDatabase` is instantiated, opening the SQLite database `schedium` via `drift_flutter`.
3. `PersistentListSignal.loadFromDB(db, db.tasks, (r) => model.PersistentTask.fromRow(r))` initializes an empty signal list, queries the tasks table asynchronously, converts each row to a `PersistentTask`, and wires up reactive persistence (`item.syncToDB(db, table)`).
4. An `AppState` is created with the title `Schedium`, the database-backed `tasks` signal, and `nodeId: 0` for Snowflake ID generation.
5. The `Home` screen is pushed onto the navigation history and `runApp` starts `SchediumApp`.

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
                └──► PersistentTask.syncToDB / PersistentListSignal.add ──► Drift (SQLite)
```

State flows one way: widgets mutate signals, and reactive subscriptions
(`PersistentTask.syncToDB` for task field updates, and `PersistentListSignal.add`
for new entries) automatically write changes through to the SQLite database via
Drift.

## Widget base class

Screens and reusable components that need app-wide state extend `schedium.Widget`,
which is a `StatelessWidget` with an `appState` field. Purely presentational widgets
(for example `StateChip`, `TitleField`) extend `StatelessWidget` directly and receive
only what they need as constructor parameters.
