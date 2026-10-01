import 'package:flutter/cupertino.dart';
import 'package:schedium/model/model.dart' as model;
import 'package:schedium/schedium.dart' as schedium;
import 'package:signals_flutter/signals_flutter.dart';

class AppState {
  AppState({required this.title, required this.tasks, Widget? currentScreen}) {
    if (currentScreen != null) navigation.history.add(currentScreen);
  }

  final Signal<String> title;
  final Signal<List<model.Task>> tasks;

  final schedium.Navigation navigation = schedium.Navigation();
  late final FlutterComputed<Widget> currentScreen = computed(
    () => navigation.history.value.last,
  );
}
