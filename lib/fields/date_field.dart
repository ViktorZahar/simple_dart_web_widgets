import 'dart:html';

import '../abstract_component.dart';
import '../mixins.dart';
import '../utils.dart';

class DateField extends Component with Field<DateTime>, MixinDisable {
  DateField() : super('DateField') {
    nodeRoot.onChange.listen((event) {
      try {
        final newValue = value;
        fireValueChange(newValue, newValue);
      } on Exception catch (_) {}
    });
  }

  @override
  DateInputElement nodeRoot = DateInputElement();

  @override
  List<Element> get disableNodes => [nodeRoot];

  String get textAlign => nodeRoot.style.textAlign;

  set textAlign(String value) => nodeRoot.style.textAlign = value;

  @override
  DateTime get value {
    if (nodeRoot.valueAsNumber == null) {
      throw Exception('bad field value');
    }
    if (nodeRoot.valueAsNumber!.isNaN) {
      throw Exception('bad field value');
    }
    return DateTime.fromMillisecondsSinceEpoch(
        (nodeRoot.valueAsNumber ?? 0).ceil(),
        isUtc: true);
  }

  @override
  set value(DateTime value) {
    final newValue = formatDate(value);
    nodeRoot.value = newValue;
  }

  String getStringValue() => formatDate(value);

  @override
  void focus() {
    nodeRoot.focus();
  }
}
