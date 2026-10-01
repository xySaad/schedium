import 'package:flutter/material.dart';
import 'package:schedium/model/model.dart' as model;
import 'package:schedium/schedium.dart' as schedium;
import 'package:schedium/ui/theme/palette.dart';

import '../widgets/description_field.dart';
import '../widgets/section_label.dart';
import '../widgets/task/state_selector.dart';
import '../widgets/task/task_menu.dart';
import '../widgets/title_field.dart';

class Task extends schedium.Widget {
  const Task(super.appState, {super.key, required this.data});
  final model.Task data;

  void saveTitle(String value) {
    data.title.value = value;
  }

  void saveDescription(String value) {
    data.description.value = value;
  }

  @override
  Widget build(BuildContext context) {
    final titleCtrl = TextEditingController(text: data.title.peek());
    final descCtrl = TextEditingController(text: data.description.peek());
    titleCtrl.addListener(() => data.title.value = titleCtrl.text);
    descCtrl.addListener(() => data.description.value = descCtrl.text);

    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TitleField(
                            controller: titleCtrl,
                            onSubmitted: saveTitle,
                          ),
                        ),
                        TaskMenu(appState, task: data),
                      ],
                    ),
                    const SizedBox(height: 16),
                    StateSelector(task: data),
                    const SizedBox(height: 28),
                    const SectionLabel('Description'),
                    const SizedBox(height: 8),
                    DescriptionField(
                      controller: descCtrl,
                      onChanged: saveDescription,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
