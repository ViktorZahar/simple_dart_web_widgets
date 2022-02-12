import 'dart:html';

import '../abstract_component.dart';
import '../mixins.dart';
import '../utils.dart';

class DateTimeField extends Component with Field<DateTime>, MixinDisable {
  DateTimeField() {
    nodeRoot.onChange.listen((event) {
      fireValueChange(value, value);
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
  DateTime get value =>
      DateTime.fromMillisecondsSinceEpoch((nodeRoot.valueAsNumber ?? 0).ceil(),
          isUtc: true);

  @override
  set value(DateTime value) {
    var newValue = '';
    newValue = formatDateTimeText(value);
    nodeRoot.value = newValue;
  }

  String getStringValue() => formatDateTime(value);

  @override
  void focus() {
    nodeRoot.focus();
  }
}
