# Schedium – Agent Rules

## Flutter & Dart conventions

### Reactivity: Signals only, no StatefulWidget

- **Never** create a `StatefulWidget` or `State<T>` subclass.
- Manage all mutable/reactive state with `signals_flutter` signals
  (`signal()`, `computed()`, `effect()`).
- Use `SignalBuilder(...)` not `Watch(...)` for fine-grained reactive rebuilds
  inside `build()` instead of `setState`.
- Controllers that need lifecycle (e.g. `TextEditingController`) should be
  instantiated directly (wrapping them in signals is redundant) and use `effect()`
  with a dispose callback when a resource must be cleaned up.

### Naming: No underscore-prefixed declarations

- **Never** name a class, function, variable, or parameter with a leading `_`
  (e.g. `_MyWidget`, `_buildRow`, `_value`).
- Use descriptive, non-private names. Scope privacy through file structure and
  named imports (`import … as foo`) rather than Dart's leading-underscore
  convention.
- This applies to widget classes, helper widgets, local variables, and
  top-level/static functions alike.
- **Never** call a task `Todo`. All naming must use `Task` instead.

### Widget architecture

- Extend `schedium.Widget` (which extends `StatelessWidget`) for all screens
  and reusable UI components that need access to `AppState`.
- Pure presentational widgets that need no `AppState` may extend
  `StatelessWidget` directly.
- Prefer small, focused widget classes over large monolithic `build()` methods.
- **Never** write two widgets in the same file. Each widget must be in its own file.

### Testing

- **Never** generate or run tests.

### Deprecations

- `Color.withOpacity` is deprecated and shouldn't be used. Use `.withValues(alpha: ...)` to avoid precision loss.
