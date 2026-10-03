# Data model

## `Task` (`lib/model/task/task.dart`)

| Field | Type | Notes |
| --- | --- | --- |
| `id` | `int` | Unique identifier (Snowflake) |
| `title` | `Signal<String>` | Required |
| `description` | `Signal<String?>` | Optional |
| `state` | `Signal<TaskState>` | Defaults to `TaskState.undone` |
| `isDeleted` | `Signal<bool>` | Soft-delete flag, defaults to `false` |

All mutable fields are signals, so UI that reads them inside a `SignalBuilder` updates
automatically.

## `PersistentTask` (`lib/model/task/persistent_task.dart`)

Extends `Task` and implements `PersistentItem<database.$TasksTable, database.Task>` to provide automatic SQLite persistence via Drift.

- `PersistentTask.fromRow(database.Task task)`: Creates an instance from a Drift database row.
- `toCompanion()`: Maps the task signals to a `database.Task` row object.
- `syncToDB(GeneratedDatabase db, TaskTableInfo table)`: Subscribes to the `title`, `description`, `state`, and `isDeleted` signals, writing changes to SQLite whenever any signal is mutated.

## Database schema (`lib/database/tables/tasks_table.dart`)

Tasks are stored in a local SQLite database named `'schedium'` using Drift (`AppDatabase` in `lib/database/database.dart`).

The `Tasks` table defines:

| Column | Drift Type | Dart Type | Notes |
| --- | --- | --- | --- |
| `id` | `IntColumn` | `int` | Primary key (Snowflake ID) |
| `title` | `TextColumn` | `String` | Required |
| `description` | `TextColumn` | `String?` | Nullable |
| `state` | `TextColumn` | `TaskState` | Stored as text enum (`textEnum<TaskState>()`) |
| `isDeleted` | `BoolColumn` | `bool` | Soft-delete flag |

## `TaskState` (`lib/model/task/task_state.dart`)

An enum carrying its own presentation data:

| Value | Icon | Colour |
| --- | --- | --- |
| `undone` | `radio_button_unchecked_rounded` | `Palette.muted` |
| `done` | `check_circle_rounded` | `Palette.done` |
| `ignored` | `remove_circle_rounded` | `Palette.ignored` |

## `AppState` (`lib/model/app_state.dart`)

| Member | Type | Purpose |
| --- | --- | --- |
| `title` | `Signal<String>` | App bar title |
| `tasks` | `PersistentListSignal<database.Task, model.PersistentTask>` | Database-backed reactive task list |
| `navigation` | `Navigation` | Screen history stack |
| `currentScreen` | `Computed<Widget>` | Top of the history stack |
| `nextId` | `Snowflake` | Snowflake generator for unique 64-bit entity IDs |

## Persistence (`PersistentListSignal`, `PersistentTask`, `AppDatabase`)

- Storage: SQLite via `drift` and `drift_flutter` (database name: `'schedium'`).
- `PersistentListSignal.loadFromDB(db, table, rowToItem)` queries stored rows asynchronously on startup, instantiates `PersistentTask`s, hooks up their DB sync, and emits the list to signal subscribers.
- Adding a task via `appState.tasks.add(task)` inserts the record into the database table and attaches `syncToDB` to watch for future signal mutations.
- `TaskService` (`lib/model/task/task_service.dart`) provides helper methods (`loadAll`, `update`, `rowToTask`) for querying and updating tasks directly on the database.

## Deleting tasks

Deletion is a **soft delete**: `task.isDeleted.value = true`. The task's `syncToDB` listener automatically updates the `isDeleted` column in the database; `Home` filters out tasks where `isDeleted` is true.
