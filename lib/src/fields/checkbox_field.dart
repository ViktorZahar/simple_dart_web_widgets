import 'dart:html';

import '../../widgets.dart';

class CheckboxField extends Component with Field<bool> {
  CheckboxField() {
    nodeRoot.style
      ..display = 'flex'
      ..textAlign = 'center'
      ..justifyContent = 'left';

    _checkBoxInput = CheckboxInputElement();
    _checkBoxInput.style
      ..fontSize = '16px'
      ..fontFamily = WidgetsTheme.basicFont;
    nodeRoot.setAttribute('Name', 'CheckBox');

    _label = LabelElement()..style.paddingRight = '5px';

    nodeRoot.children.add(_checkBoxInput);
    nodeRoot.children.add(_label);
  }

  @override
  DivElement nodeRoot = DivElement();
  CheckboxInputElement _checkBoxInput;
  LabelElement _label;
  int _fontSize = 16;

  @override
  set width(String width) {
    _checkBoxInput.style.width = width;
    nodeRoot.style.width = width;
  }

  @override
  set height(String height) {
    _checkBoxInput.style.height = height;
    nodeRoot.style.height = height;
  }

  set fontSize(int size) {
    _fontSize = size;
    _checkBoxInput.style.fontSize = '${size}px';
  }

  int get fontSize => _fontSize;

  void onChange(Function(Event event) listener) {
    _checkBoxInput.onChange.listen((e) {
      listener(e);
    });
  }

  @override
  bool get value => _checkBoxInput.checked;

  @override
  set value(bool value) => _checkBoxInput.checked = value;

  set caption(String caption) => _label.text = caption;

  String get caption => _label.text;

  @override
  void focus() {
    _checkBoxInput.focus();
  }
}
