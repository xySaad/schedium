export 'state.dart';

import 'package:schedium/model/task/state.dart';
import 'package:signals_flutter/signals_flutter.dart';

class Task {
  Task({required this.title, String? description, State? state, bool isDeleted = false})
    : description = signal(description),
      state = signal(state ?? State.undone),
      isDeleted = signal(isDeleted);

  final Signal<String> title;
  final Signal<String?> description;
  final Signal<State> state;
  final Signal<bool> isDeleted;

  Map<String, dynamic> toJson() => {
        'title': title.value,
        'description': description.value,
        'state': state.value.name,
        'isDeleted': isDeleted.value,
      };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        title: signal(json['title'] as String),
        description: json['description'] as String?,
        state: State.values.firstWhere(
          (e) => e.name == json['state'],
          orElse: () => State.undone,
        ),
        isDeleted: json['isDeleted'] as bool? ?? false,
      );
}
