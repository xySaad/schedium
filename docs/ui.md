# UI

## Theme

`buildAppTheme()` (`lib/ui/theme/app_theme.dart`) returns a Material 3 dark theme
based on `Palette`, with a flat circular floating action button and a rounded
bottom-sheet style.

### Palette (`lib/ui/theme/palette.dart`)

| Name | Hex | Use |
| --- | --- | --- |
| `background` | `#101114` | Scaffold background |
| `surface` | `#181A1F` | Cards, dialogs, menus, fields |
| `outline` | `#2C2F37` | Borders |
| `text` | `#E7E8EC` | Primary text |
| `muted` | `#7C818C` | Secondary text, inactive icons |
| `accent` | `#8FB8DE` | Primary colour, FAB, non-destructive actions |
| `done` | `#6DBF8A` | Done state |
| `ignored` | `#C76730` | Ignored state |

Use `Color.withValues(alpha: ...)` for transparency; `withOpacity` is deprecated.

## Screens (`lib/ui/screens/`)

Import via the barrel with a prefix: `import 'screens.dart' as screens;`.

### `Home`
- Lists tasks where `isDeleted` is false, inside a `SignalBuilder`.
- Shows "No tasks yet" when the list is empty.
- The floating action button creates a task titled "New Task", adds it to
  `appState.tasks` and opens it.
- Tapping a tile opens the task screen.

### `Task`
- Editable title (`TitleField`), a `TaskMenu` (overflow menu), a `StateSelector`
  and an editable description (`DescriptionField`).
- Edits are written straight into the task's signals as the user types, which in
  turn triggers saving.

## Widgets (`lib/ui/widgets/`)

Every widget lives in its own file.

| Widget | File | Description |
| --- | --- | --- |
| `TaskTile` | `task/task_tile.dart` | Home list row: state chip, title, description preview. Tap opens the task; tapping the chip toggles undone/done; long-pressing toggles ignored/undone. Border colour follows the state. |
| `TaskMenu` | `task/task_menu.dart` | Overflow (⋮) menu on the task screen. Currently offers **Delete**. |
| `StateSelector` | `task/state_selector.dart` | Two toggleable chips (`done`, `ignored`); selecting the active chip returns the task to `undone`. |
| `StateChip` | `state_chip.dart` | Pill-shaped icon (+ optional label) button with press animation. |
| `ConfirmationDialog` | `confirmation_dialog.dart` | Themed `AlertDialog`; pops `true` on confirm, `false` on cancel. |
| `TitleField` | `title_field.dart` | Large borderless text field for the title. |
| `DescriptionField` | `description_field.dart` | Multi-line field in a rounded surface container. |
| `SectionLabel` | `section_label.dart` | Small muted label above a section. |

### `ConfirmationDialog`

```dart
final result = await showDialog<bool>(
  context: context,
  builder: (dialogContext) => ConfirmationDialog(
    title: 'Delete task?',
    description: 'This cannot be undone.',
    confirmLabel: 'Delete',
    // cancelLabel: 'Cancel',   // default
    // destructive: true,       // red confirm button (default); false uses the accent colour
  ),
);
final confirmed = result ?? false;
```

### `TaskMenu`

`TaskMenu(appState, task: task)` is a `PopupMenuButton<TaskMenuAction>`. Add new
actions by extending the `TaskMenuAction` enum, adding a `PopupMenuItem` in
`itemBuilder`, and handling the new case in `onSelected`.
