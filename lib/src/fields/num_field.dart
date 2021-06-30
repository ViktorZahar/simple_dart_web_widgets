import 'dart:html';

import '../../widgets.dart';

class NumField extends Component with Field<num>, MixinDisablable {
  NumField() {
    nodeRoot.style
      ..display = 'flex'
      ..justifyContent = 'center';
    numberInput.style
      ..fontSize = '16px'
      ..fontFamily = WidgetsTheme.basicFont
      ..width = '100%'
      ..textAlign = 'end'
      ..flexGrow = '1';
    nodeRoot.setAttribute('Name', 'NumField');
    nodeRoot.children.add(numberInput);
    numberInput.onInput.listen((event) {
      fireValueChange(value, value);
    });
  }

  @override
  DivElement nodeRoot = DivElement();

  @override
  List<Element> get disablableNodes => [numberInput];
  NumberInputElement numberInput = NumberInputElement();
  int _fontSize = 16;

  @override
  set width(String width) {
    numberInput.style.width = width;
    nodeRoot.style.width = width;
  }

  @override
  set height(String height) {
    nodeRoot.style.height = height;
  }

  set fontSize(int size) {
    _fontSize = size;
    numberInput.style.fontSize = '${size}px';
  }

  int get fontSize => _fontSize;

  void onChange(Function(Event event) listener) {
    numberInput.onChange.listen((e) {
      listener(e);
    });
  }

  String get textAlign => numberInput.style.textAlign;

  set textAlign(String value) => numberInput.style.textAlign = value;

  @override
  num get value => num.tryParse(numberInput.value!) ?? 0;

  @override
  set value(num value) => numberInput.value = value.toString();

  @override
  void focus() {
    numberInput.focus();
  }
}
