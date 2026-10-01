# Schedium Documentation

Schedium is a small, dark-themed Flutter app for managing tasks. Each task has a
title, an optional description and a state (`undone`, `done` or `ignored`). Tasks
are stored locally on the device.

## Contents

| Document                        | What it covers                                                       |
| ------------------------------- | -------------------------------------------------------------------- |
| [Architecture](architecture.md) | Project layout, app startup, navigation, data flow                   |
| [Data model](data-model.md)     | `Task`, `State`, `AppState` and JSON persistence                     |
| [UI](ui.md)                     | Screens, widgets, theme and palette                                  |
| [Features](features.md)         | User-facing behaviour: creating, editing, completing, deleting tasks |

## Tech stack

- **Flutter** (Material 3, dark theme)
- **signals_flutter**: all reactive state (`signal`, `computed`, `effect`, `SignalBuilder`)
- **shared_preferences**: local persistence of tasks as a JSON string

## Quick start

```bash
flutter pub get
flutter run
```

The app entry point is `lib/main.dart`.
