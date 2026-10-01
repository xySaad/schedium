# Data model

## `Task` (`lib/model/task/task.dart`)

| Field | Type | Notes |
| --- | --- | --- |
| `title` | `Signal<String>` | Required |
| `description` | `Signal<String?>` | Optional |
| `state` | `Signal<State>` | Defaults to `State.undone` |
| `isDeleted` | `Signal<bool>` | Soft-delete flag, defaults to `false` |

All fields are signals, so UI that reads them inside a `SignalBuilder` updates
automatically, and the persistence effect in `main.dart` notices changes.

### JSON shape

```json
{
  "title": "Buy milk",
  "description": "Semi-skimmed",
  "state": "undone",
  "isDeleted": false
}
```

`Task.fromJson` falls back to `State.undone` for an unknown state name and to
`false` for a missing `isDeleted`, so older saved data keeps loading.

## `State` (`lib/model/task/state.dart`)

An enum carrying its own presentation data:

| Value | Icon | Colour |
| --- | --- | --- |
| `undone` | `radio_button_unchecked_rounded` | `Palette.muted` |
| `done` | `check_circle_rounded` | `Palette.done` |
| `ignored` | `remove_circle_rounded` | `Palette.ignored` |

Because the enum is named `State`, import the model barrel with a prefix
(`import 'package:schedium/model/model.dart' as model;` → `model.State`) to avoid
clashing with Flutter's `State<T>`.

## `AppState` (`lib/model/app_state.dart`)

| Member | Type | Purpose |
| --- | --- | --- |
| `title` | `Signal<String>` | App bar title |
| `tasks` | `Signal<List<Task>>` | All tasks, including soft-deleted ones |
| `navigation` | `Navigation` | Screen history stack |
| `currentScreen` | `Computed<Widget>` | Top of the history stack |

## Persistence (`TaskService`)

- Storage: `SharedPreferences`, key `tasks`, value is a JSON-encoded list of tasks.
- `saveTasks(List<Task>)` serialises every task (including soft-deleted ones).
- `loadTasks()` returns `[]` when nothing is stored or when decoding fails.

## Deleting tasks

Deletion is a **soft delete**: `task.isDeleted.value = true`. The task stays in
`appState.tasks` and in storage; `Home` filters out tasks where `isDeleted` is true.
