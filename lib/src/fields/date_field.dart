import 'dart:html';

import '../../widgets.dart';

class DateField extends Component with Field<DateTime>, MixinDisablable {
  DateField() {
    nodeRoot.style
      ..display = 'flex'
      ..textAlign = 'center'
      ..justifyContent = 'center';

    _textInput = DateInputElement();
    _textInput.style
      ..fontSize = '16px'
      ..fontFamily = WidgetsTheme.basicFont
      ..width = '100%'
      ..flexGrow = '1';
    nodeRoot.setAttribute('Name', 'TextField');
    nodeRoot.children.add(_textInput);
    nodeRoot.onChange.listen((event) {
      fireValueChange(value, value);
    });
  }

  @override
  DivElement nodeRoot = DivElement();
  @override
  List<Element> get disablableNodes => [_textInput];
  DateInputElement _textInput;
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

  void onChange(Function(Event event) listener) {
    _textInput.onChange.listen((e) {
      listener(e);
    });
  }

  String get textAlign => _textInput.style.textAlign;

  set textAlign(String value) => _textInput.style.textAlign = value;

  @override
  DateTime get value {
    return _textInput.valueAsDate;
  }

  @override
  set value(DateTime value) => _textInput.value = formatDate(value);

  @override
  void focus() {
    _textInput.focus();
  }

  String formatDate(DateTime date) {
    return '${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
