import 'dart:html';

import 'package:simple_dart_web_widgets/widgets.dart';

class TextField extends Component implements Field<String> {
  TextField() {
    nodeRoot.style
      ..display = 'flex'
      ..textAlign = 'center'
      ..justifyContent = 'center';

    _textInput = TextInputElement();
    _textInput.style
      ..fontSize = '16px'
      ..fontFamily = WidgetsTheme.basicFont
      ..width = '100%'
      ..flexGrow = '1';
    nodeRoot.setAttribute('Name', 'TextField');
    nodeRoot.children.add(_textInput);
  }

  @override
  DivElement nodeRoot = DivElement();
  TextInputElement _textInput;
  int _fontSize = 16;

  @override
  set width(String width) {
    _textInput.style.width = width;
    nodeRoot.style.width = width;
  }

  @override
  set height(String height) {
    _textInput.style.height = height;
    nodeRoot.style.height = height;
  }

  set fontSize(int size) {
    _fontSize = size;
    _textInput.style.fontSize = '${size}px';
  }

  int get fontSize => _fontSize;

  void onChange(listener(Event event)) {
    _textInput.onChange.listen((e) {
      listener(e);
    });
  }

  @override
  String get value => _textInput.value;

  @override
  set value(String value) => _textInput.value = value;

  @override
  void focus() {
    _textInput.focus();
  }

  void disable() {
    _textInput.disabled = true;
  }
}
