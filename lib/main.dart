import 'package:flutter/material.dart';
import 'package:schedium/model/model.dart' as model;
import 'package:schedium/database/database.dart';
import 'package:schedium/schedium/persistent_list_signal.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'ui/screens/screens.dart' as screens;
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = AppDatabase();
  final tasks = PersistentListSignal.loadFromDB(
    db,
    db.tasks,
    (r) => model.PersistentTask.fromRow(r),
  );

  final appState = model.AppState(
    title: signal('Schedium'),
    tasks: tasks,
    nodeId: 0,
  );

  appState.navigation.history.add(screens.Home(appState));
  runApp(SchediumApp(appState));
}
