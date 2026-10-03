# Schedium Documentation

Schedium is a small, dark-themed Flutter app for managing tasks. Each task has a
title, an optional description and a state (`undone`, `done` or `ignored`). Tasks
are stored locally on the device.

## Contents

| Document                             | What it covers                                                       |
| ------------------------------------ | -------------------------------------------------------------------- |
| [Architecture](docs/architecture.md) | Project layout, app startup, navigation, data flow                   |
| [Data model](docs/data-model.md)     | `Task`, `TaskState`, `AppState`, and Drift (SQLite) persistence      |
| [UI](docs/ui.md)                     | Screens, widgets, theme and palette                                  |
| [Features](docs/features.md)         | User-facing behaviour: creating, editing, completing, deleting tasks |

## Tech stack

- **Flutter** (Material 3, dark theme)
- **signals_flutter**: all reactive state (`signal`, `computed`, `effect`, `SignalBuilder`)
- **drift** & **drift_flutter**: local SQLite database persistence
- **snowflake_dart**: unique ID generation for tasks

## Quick start

```bash
flutter pub get
flutter run
```

The app entry point is `lib/main.dart`.
