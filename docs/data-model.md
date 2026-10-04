# Data model

## `Task` (`lib/database/tables/tasks_table.drift.dart` — generated)

`Task` is the Drift-generated data class for the `Tasks` table. Its fields use
`DriftSignal<T>` types (see `DriftSignal` below) because each column is mapped
through a `SignalConverter` in the table definition.

| Field | Dart type | Notes |
| --- | --- | --- |
| `id` | `int` | Primary key (Snowflake) |
| `title` | `DriftSignal<String>` | Required |
| `description` | `DriftSignal<String?>` | Optional |
| `state` | `DriftSignal<TaskState>` | Defaults to `TaskState.undone` |
| `isDeleted` | `DriftSignal<bool>` | Soft-delete flag, defaults to `false` |

All mutable fields are `DriftSignal`s, so UI that reads them inside a
`SignalBuilder` updates automatically, and mutations are automatically written
back to SQLite.

## `TaskModel` (`lib/model/task/task_model.dart`)

Extends the Drift `Task` row class and mixes in `PersistentRow<$TasksTable, Task>`
to provide automatic per-column SQLite persistence.

```
TaskModel extends Task with PersistentRow<$TasksTable, Task>
```

**Named constructor:**

`TaskModel.create(int id, String title, {String? description, TaskState state, bool isDeleted})`
— wraps each argument in a `DriftSignal` and calls the `Task` super constructor.
Use this when creating a new task in the UI.

**`PersistentRow` contract:**

| Member | Purpose |
| --- | --- |
| `Expression<bool> filter($TasksTable t)` | Produces the `WHERE id = …` clause used by all UPDATE statements |
| `List<(DriftSignal, TasksCompanion)> get columns` | Pairs each `DriftSignal` field with the partial `TasksCompanion` that writes it |

Calling `syncToDB(db, table)` (inherited from `PersistentRow`) iterates `columns`
and calls `DriftSignal.subscribeToDB` on each entry, so every field mutation
immediately issues a targeted `UPDATE` through Drift.

## `DriftSignal<T>` and `SignalConverter<D, S>` (`lib/schedium/drift_converters.dart`)

### `DriftSignal<T>`

Extends `Signal<T>` with one extra method:

```dart
void Function() subscribeToDB<Ti, R>(
  GeneratedDatabase db, Ti table,
  Expression<bool> Function(Ti) filter,
  UpdateCompanion<R> companion,
)
```

Subscribes to its own value changes and fires a Drift `UPDATE` statement (scoped
by `filter`) on every mutation. Returns the unsubscribe callback.

Equality is value-based (`==` / `hashCode` delegate to `value`), which is required
for Drift's data-class diffing.

### `SignalConverter<D, S>`

A Drift `TypeConverter<DriftSignal<D>, S>` that converts a raw SQL value `S` into
a `DriftSignal<D>` on read, and unwraps it back to `S` on write. Three factory
constructors cover common cases:

| Factory | Use |
| --- | --- |
| `SignalConverter.plain<T>()` | Non-nullable value stored as-is (e.g. `String`, `bool`) |
| `SignalConverter.nullable<T>()` | Nullable value (e.g. `String?`) |
| `SignalConverter.forEnum<T>(values)` | Enum stored by `.name` |

Because `SignalConverter` is applied at the table-definition level, Drift's
generated `Task` data class already has `DriftSignal` fields — no manual wrapping
is needed when loading rows.

## `PersistentRow<Ti, R>` (`lib/schedium/persistent_item.dart`)

A mixin on `Insertable<R>` that adds database-sync behaviour to any model class:

```dart
mixin PersistentRow<Ti extends TableInfo<Ti, R>, R> on Insertable<R> {
  List<(DriftSignal, UpdateCompanion<R>)> get columns;
  Expression<bool> filter(Ti t);

  void syncToDB(GeneratedDatabase db, Ti table) { … }
}
```

`syncToDB` iterates `columns` and calls `subscribeToDB` on each `DriftSignal`,
wiring the signal → DB pipeline for every mutable field.

## Database schema (`lib/database/tables/tasks_table.dart`)

Tasks are stored in a local SQLite database named `'schedium'` using Drift
(`AppDatabase` in `lib/database/database.dart`).

The `Tasks` table defines:

| Column | Drift type | Dart type | Converter | Notes |
| --- | --- | --- | --- | --- |
| `id` | `IntColumn` | `int` | — | Primary key (Snowflake ID) |
| `title` | `TextColumn` | `DriftSignal<String>` | `SignalConverter.plain()` | Required |
| `description` | `TextColumn` | `DriftSignal<String?>` | `SignalConverter.nullable()` | Nullable |
| `state` | `TextColumn` | `DriftSignal<TaskState>` | `SignalConverter.forEnum(TaskState.values)` | Stored as enum name |
| `isDeleted` | `BoolColumn` | `DriftSignal<bool>` | `SignalConverter.plain()` | Soft-delete flag |

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
| `tasks` | `PersistentListSignal<$TasksTable, Task, TaskModel>` | Database-backed reactive task list |
| `navigation` | `Navigation` | Screen history stack |
| `currentScreen` | `Computed<Widget>` | Top of the history stack |
| `nextId` | `Snowflake` | Snowflake generator for unique 64-bit entity IDs |

## Persistence (`PersistentListSignal`, `TaskModel`, `AppDatabase`)

- Storage: SQLite via `drift` and `drift_flutter` (database name: `'schedium'`).
- `PersistentListSignal<$TasksTable, Task, TaskModel>.loadFromDB(db, table, rowToItem)`
  queries stored rows asynchronously on startup. Because `SignalConverter` runs
  during the Drift query, each row arrives with `DriftSignal` fields already
  populated; the `rowToItem` closure forwards them to `TaskModel(...)` directly.
- Each loaded item has `syncToDB(db, table)` called, subscribing all its
  `DriftSignal` columns to fire DB updates on mutation.
- Adding a task via `appState.tasks.add(task)` inserts the record into the database
  and attaches `syncToDB` to watch for future signal mutations.

## Deleting tasks

Deletion is a **soft delete**: `task.isDeleted.value = true`. The task's
`DriftSignal.subscribeToDB` listener automatically updates the `isDeleted` column
in the database; `Home` filters out tasks where `isDeleted` is true.
