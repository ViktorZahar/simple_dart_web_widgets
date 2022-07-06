import 'dart:html';

import '../abstract_component.dart';
import '../mixins.dart';

class TextAreaField extends Component
    with Field<String>, MixinDisable, UrlStateComponent<String> {
  TextAreaField() : super('TextAreaField') {
    nodeRoot.onInput.listen((event) {
      fireValueChange(value, value);
    });
  }

  @override
  TextAreaElement nodeRoot = TextAreaElement();

  @override
  List<Element> get disableNodes => [nodeRoot];

  String get textAlign => nodeRoot.style.textAlign;

  set textAlign(String value) => nodeRoot.style.textAlign = value;

  @override
  String get value => nodeRoot.value ?? '';

  @override
  set value(String value) => nodeRoot.value = value;

  @override
  String get urlState => value;

  @override
  set urlState(String newValue) => value = newValue;

  @override
  void focus() {
    nodeRoot.focus();
  }
}
