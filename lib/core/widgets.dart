import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FieldDef {
  const FieldDef(this.key, this.label, {this.number = false, this.initial = ''});
  final String key, label, initial;
  final bool number;
}

Future<Map<String, String>?> formDialog(String title, List<FieldDef> fields) {
  final ctrls = {for (final f in fields) f.key: TextEditingController(text: f.initial)};
  return Get.dialog<Map<String, String>>(AlertDialog(
    title: Text(title.tr),
    content: SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        for (final f in fields)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: TextField(
              controller: ctrls[f.key],
              keyboardType: f.number ? TextInputType.number : TextInputType.text,
              decoration: InputDecoration(labelText: f.label.tr, border: const OutlineInputBorder()),
            ),
          ),
      ]),
    ),
    actions: [
      TextButton(onPressed: () => Get.back(), child: Text('cancel'.tr)),
      FilledButton(
        onPressed: () => Get.back(result: {for (final e in ctrls.entries) e.key: e.value.text.trim()}),
        child: Text('save'.tr),
      ),
    ],
  ));
}

Future<T?> pickDialog<T>(String title, List<T> items, String Function(T) label) =>
    Get.dialog<T>(SimpleDialog(
      title: Text(title.tr),
      children: [
        for (final i in items)
          SimpleDialogOption(onPressed: () => Get.back(result: i), child: Text(label(i))),
      ],
    ));

Future<List<String>?> multiPick(String title, Map<String, String> opts, List<String> selected) {
  final sel = selected.toSet().obs;
  return Get.dialog<List<String>>(AlertDialog(
    title: Text(title.tr),
    content: SizedBox(
      width: double.maxFinite,
      child: Obx(() => ListView(shrinkWrap: true, children: [
            for (final e in opts.entries)
              CheckboxListTile(
                value: sel.contains(e.key),
                title: Text(e.value),
                onChanged: (v) {
                  if (v == true) {
                    sel.add(e.key);
                  } else {
                    sel.remove(e.key);
                  }
                },
              ),
          ])),
    ),
    actions: [FilledButton(onPressed: () => Get.back(result: sel.toList()), child: Text('save'.tr))],
  ));
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});
  @override
  Widget build(BuildContext context) => Center(child: Text('empty'.tr));
}

void toast(String key) => Get.snackbar('app_name'.tr, key.tr);
