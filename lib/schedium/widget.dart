import 'package:flutter/material.dart' as material;
import 'package:schedium/model/app_state.dart';

abstract class Widget extends material.StatelessWidget {
  const Widget(this.appState, {super.key});
  final AppState appState;
}
