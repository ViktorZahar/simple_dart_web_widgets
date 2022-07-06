import 'dart:html';

import '../abstract_component.dart';
import '../mixins.dart';
import '../utils.dart';

class DateTimeField extends Component
    with Field<DateTime>, UrlStateComponent<DateTime>, MixinDisable {
  DateTimeField() : super('DateTimeField') {
    nodeRoot.onChange.listen((event) {
      try {
        final newValue = value;
        fireValueChange(newValue, newValue);
      } on Exception catch (_) {}
    });
  }

  @override
  LocalDateTimeInputElement nodeRoot = LocalDateTimeInputElement();

  @override
  List<Element> get disableNodes => [nodeRoot];

  void onChange(Function(Event event) listener) {
    nodeRoot.onChange.listen((e) {
      listener(e);
    });
  }

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
    var newValue = '';
    newValue = formatDateTimeText(value);
    nodeRoot.value = newValue;
  }

  @override
  String get urlState => getStringValue();

  @override
  set urlState(String newValue) => value = DateTime.fromMillisecondsSinceEpoch(
      (nodeRoot.valueAsNumber ?? 0).ceil(),
      isUtc: true);

  String getStringValue() => formatDateTime(value);

  @override
  void focus() {
    nodeRoot.focus();
  }
}
