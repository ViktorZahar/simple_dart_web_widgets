import 'abstract_component.dart';
import 'hv_panel.dart';
import 'labels/simple_label.dart';

String formatDate(DateTime date) => '${date.year.toString()}-'
    '${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')}';

String formatDateTime(DateTime date) => '${date.year.toString()}-'
    '${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')} '
    '${date.hour.toString().padLeft(2, '0')}:'
    '${date.minute.toString().padLeft(2, '0')}:'
    '${date.second.toString().padLeft(2, '0')}';

String formatDateTimeText(DateTime date) =>
    date.toIso8601String().substring(0, 16);

HVPanel labelComponent(String caption, Component comp) => HVPanel()
  ..fullWidth()
  ..addAll([
    SimpleLabel()
      ..caption = caption
      ..width = '50%',
    comp
  ]);
