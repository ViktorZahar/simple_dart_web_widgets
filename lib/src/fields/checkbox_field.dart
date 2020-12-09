import 'dart:html';

import '../../widgets.dart';

class CheckboxField extends Component with Field<bool>, MixinDisablable {
  CheckboxField() {
    dartClassName('CheckboxField');
    nodeRoot.style
      ..display = 'flex'
      ..textAlign = 'center'
      ..justifyContent = 'left'
      ..alignItems = 'center';

    _checkBoxInput = CheckboxInputElement()
      ..onChange.listen((event) {
        fireValueChange(value, value);
      });
    _checkBoxInput.style
      ..width = '18px'
      ..height = '18px'
      ..fontFamily = WidgetsTheme.basicFont;

    _label = LabelElement()..style.paddingRight = '5px';

    nodeRoot.children.add(_checkBoxInput);
    nodeRoot.children.add(_label);
  }

  @override
  DivElement nodeRoot = DivElement();
  @override
  List<Element> get disablableNodes => [_checkBoxInput];
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
    _label.style.fontSize = '${size}px';
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
  set value(bool value) {
    final oldValue = _checkBoxInput.checked;
    _checkBoxInput.checked = value;
    fireValueChange(oldValue, value);
  }

  set caption(String caption) => _label.text = caption;

  String get caption => _label.text;

  @override
  void focus() {
    _checkBoxInput.focus();
  }
}
