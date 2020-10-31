import 'dart:html';

import '../../widgets.dart';

class TextField extends Component with Field<String>, MixinDisablable {
  TextField({bool password = false}) {
    nodeRoot.style
      ..display = 'flex'
      ..textAlign = 'center'
      ..justifyContent = 'center';
    if (password) {
      textInput = PasswordInputElement();
    } else {
      textInput = TextInputElement();
    }
    textInput.style
      ..fontSize = '16px'
      ..fontFamily = WidgetsTheme.basicFont
      ..width = '100%'
      ..flexGrow = '1';
    nodeRoot.setAttribute('Name', 'TextField');
    nodeRoot.children.add(textInput);
    nodeRoot.onChange.listen((event) {
      fireValueChange(value, value);
    });
  }

  @override
  DivElement nodeRoot = DivElement();
  @override
  List<Element> get disablableNodes => [textInput];
  TextInputElementBase textInput;
  int _fontSize = 16;

  @override
  set width(String width) {
    textInput.style.width = width;
    nodeRoot.style.width = width;
  }

  @override
  set height(String height) {
    textInput.style.height = height;
    nodeRoot.style.height = height;
  }

  set fontSize(int size) {
    _fontSize = size;
    textInput.style.fontSize = '${size}px';
  }

  int get fontSize => _fontSize;

  void onChange(Function(Event event) listener) {
    textInput.onChange.listen((e) {
      listener(e);
    });
  }

  

  String get textAlign => textInput.style.textAlign;

  set textAlign(String value) => textInput.style.textAlign = value;

  @override
  String get value => textInput.value;

  @override
  set value(String value) => textInput.value = value;

  @override
  void focus() {
    textInput.focus();
  }
}
