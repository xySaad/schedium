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
│   ├── drift_converters.dart # DriftSignal<T> and SignalConverter<D,S>: signals that sync to DB
│   ├── persistent_item.dart  # PersistentRow<Ti,R>: mixin for DB-backed model classes
│   └── persistent_list_signal.dart # PersistentListSignal: Signal list backed by a Drift table
├── database/
│   ├── database.dart         # AppDatabase: Drift SQLite database definition & exports
│   └── tables/               # Table schemas (tasks_table.dart)
├── model/
│   ├── model.dart            # Barrel: exports AppState, Task, TaskModel, TaskState
│   ├── app_state.dart        # AppState: title, tasks, navigation, current screen, nextId
│   └── task/
│       ├── task.dart         # Barrel: re-exports TaskModel and TaskState
│       ├── task_model.dart   # TaskModel: extends Drift Task row with PersistentRow sync
│       └── task_state.dart   # TaskState enum (undone / done / ignored)
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
3. `PersistentListSignal<$TasksTable, Task, TaskModel>.loadFromDB(db, db.tasks, rowToItem)` initializes an empty signal list, queries the tasks table asynchronously, converts each Drift row to a `TaskModel`, and wires up reactive persistence (`item.syncToDB(db, table)`). The `rowToItem` closure constructs a `TaskModel` directly from the row's already-converted `DriftSignal` fields.
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
UI event ──► mutate a DriftSignal (task.title.value = ...)
                │
                ├──► SignalBuilder widgets rebuild
                └──► DriftSignal.subscribeToDB listener ──► Drift UPDATE (SQLite)

appState.tasks.add(task) ──► Drift INSERT (SQLite)
                          └──► task.syncToDB(db, table)  (subscribes all columns)
```

State flows one way: widgets mutate `DriftSignal` fields on a `TaskModel`, reactive
signal subscriptions (set up by `PersistentRow.syncToDB`) automatically issue Drift
`UPDATE` statements per-column, and `PersistentListSignal.add` handles the initial
`INSERT` for new tasks.

## Widget base class

Screens and reusable components that need app-wide state extend `schedium.Widget`,
which is a `StatelessWidget` with an `appState` field. Purely presentational widgets
(for example `StateChip`, `TitleField`) extend `StatelessWidget` directly and receive
only what they need as constructor parameters.
