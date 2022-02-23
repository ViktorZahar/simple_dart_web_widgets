import 'dart:html';

import '../abstract_component.dart';
import '../mixins.dart';

class TextField extends Component with Field<String>, MixinDisable {
  TextField({bool password = false}): super('TextField') {
    nodeRoot.style
      ..display = 'flex'
      ..textAlign = 'center'
      ..justifyContent = 'center';
    if (password) {
      textInput = PasswordInputElement();
    }
    textInput.style
      ..width = '100%'
      ..flexGrow = '1';
    nodeRoot.setAttribute('Name', 'TextField');
    nodeRoot.children.add(textInput);
    textInput.onInput.listen((event) {
      fireValueChange(value, value);
    });
  }

  @override
  DivElement nodeRoot = DivElement();

  @override
  List<Element> get disableNodes => [textInput];
  TextInputElementBase textInput = TextInputElement();

  @override
  set width(String width) {
    textInput.style.width = width;
    nodeRoot.style.width = width;
  }

  @override
  set height(String height) {
    nodeRoot.style.height = height;
  }

  String get textAlign => textInput.style.textAlign;

  set textAlign(String value) => textInput.style.textAlign = value;

  @override
  String get value => textInput.value ?? '';

  @override
  set value(String value) => textInput.value = value;

  @override
  void focus() {
    textInput.focus();
  }
}
