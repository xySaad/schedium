import 'package:flutter/cupertino.dart';
import 'package:schedium/database/database.dart' as database;
import 'package:schedium/schedium.dart' as schedium;
import 'package:schedium/schedium/persistent_list_signal.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:snowflake_dart/snowflake_dart.dart';
import 'model.dart' as model;

class AppState {
  AppState({
    required this.title,
    required this.tasks,
    Widget? currentScreen,
    required nodeId,
  }) : nextId = Snowflake(nodeId: 0) {
    if (currentScreen != null) navigation.history.add(currentScreen);
  }

  final Signal<String> title;
  final PersistentListSignal<database.Task, model.PersistentTask> tasks;
  final navigation = schedium.Navigation();
  late final currentScreen = computed(() => navigation.history.value.last);
  final Snowflake nextId;
}
