import 'dart:html';

import '../abstract_component.dart';
import '../mixins.dart';
import '../utils.dart';

class DateField extends Component with Field<DateTime>, MixinDisable {
  DateField() {
    nodeRoot.onChange.listen((event) {
      fireValueChange(value, value);
    });
  }

  @override
  DateInputElement nodeRoot = DateInputElement();

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
  DateTime get value => nodeRoot.valueAsDate;

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
