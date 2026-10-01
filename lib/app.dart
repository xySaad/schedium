import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'schedium.dart' as schedium;
import 'ui/theme/app_theme.dart';

class SchediumApp extends schedium.Widget {
  const SchediumApp(super.appState, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appState.title.peek(),
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              BackNavigation(appState),
              SignalBuilder(builder: (_) => Text(appState.title.value)),
            ],
          ),
        ),
        body: SignalBuilder(builder: (_) => appState.currentScreen.value),
      ),
    );
  }
}

class BackNavigation extends schedium.Widget {
  const BackNavigation(super.appState, {super.key});

  @override
  Widget build(BuildContext context) {
    return SignalBuilder(
      builder: (context) {
        final canGoBack = appState.navigation.history.value.length >= 2;
        return Visibility(
          visible: canGoBack,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: BackButton(
            onPressed: () {
              appState.navigation.history.removeLast();
            },
          ),
        );
      },
    );
  }
}
