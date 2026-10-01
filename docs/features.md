# Features

## Create a task
Tap the **+** button on the home screen. A task titled "New Task" is added and its
screen opens so you can rename it and add a description.

## Edit a task
On the task screen, edit the title and description directly. Changes are applied
immediately and saved automatically; there is no save button.

## Change a task's state
- **Home list:** tap the circle on the left to toggle `undone` ⇄ `done`;
  long-press it to toggle `ignored` ⇄ `undone`.
- **Task screen:** tap the **done** or **ignored** chip. Tapping the active chip
  returns the task to `undone`.

Done tasks show a strikethrough title; ignored tasks show a muted title.

## Delete a task
1. Open the task and tap the ⋮ menu in the top right.
2. Choose **Delete**.
3. Confirm in the "Delete task?" dialog.

On confirmation the app returns to the home screen and the task disappears from the
list. Cancelling (or tapping outside the dialog) leaves the task untouched.

Deletion is a soft delete: the task is flagged with `isDeleted` and remains in local
storage. There is currently no UI to restore or permanently purge deleted tasks.

## Persistence
Tasks are saved to the device automatically after every change and reloaded on the
next launch.

## Navigation
The app bar shows a back button whenever you are not on the home screen.
