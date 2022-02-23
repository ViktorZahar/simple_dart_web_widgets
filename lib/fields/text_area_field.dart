import 'dart:html';

import '../abstract_component.dart';
import '../mixins.dart';

class TextAreaField extends Component with Field<String>, MixinDisable {
  TextAreaField() : super('TextAreaField') {
    nodeRoot.onChange.listen((event) {
      fireValueChange(value, value);
    });
  }

  @override
  TextAreaElement nodeRoot = TextAreaElement();

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
  String get value => nodeRoot.value ?? '';

  @override
  set value(String value) => nodeRoot.value = value;

  @override
  void focus() {
    nodeRoot.focus();
  }
}
