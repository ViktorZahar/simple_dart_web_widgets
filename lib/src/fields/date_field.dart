import 'dart:html';

import '../../widgets.dart';

class DateField extends Component with Field<DateTime>, MixinDisableable {
  DateField() {
    nodeRoot.style
      ..display = 'flex'
      ..textAlign = 'center'
      ..justifyContent = 'center';

    _dateInput.style
      ..fontSize = '16px'
      ..fontFamily = WidgetsTheme.basicFont
      ..width = '100%'
      ..flexGrow = '1';

    _timeInput.style
      ..fontSize = '16px'
      ..fontFamily = WidgetsTheme.basicFont
      ..width = '100%'
      ..flexGrow = '1';

    nodeRoot
      ..setAttribute('Name', 'DateField')
      ..children.add(_dateInput)
      ..onChange.listen((event) {
        fireValueChange(value, value);
      });
    fontSize = WidgetsTheme.basicSize;
    height = '${WidgetsTheme.basicFieldSize}px';
  }

  @override
  DivElement nodeRoot = DivElement();

  @override
  List<Element> get disableableNodes => [_dateInput, _timeInput];
  final DateInputElement _dateInput = DateInputElement();
  final LocalDateTimeInputElement _timeInput = LocalDateTimeInputElement();
  int _fontSize = 16;
  bool _showTime = false;

  InputElementBase _currentInput() {
    if (_showTime) {
      return _timeInput;
    } else {
      return _dateInput;
    }
  }

  @override
  set width(String width) {
    _dateInput.style.width = width;
    _timeInput.style.width = width;
    nodeRoot.style.width = width;
  }

  @override
  set height(String height) {
    _dateInput.style.height = height;
    _timeInput.style.height = height;
    nodeRoot.style.height = height;
  }

  set fontSize(int size) {
    _fontSize = size;
    _dateInput.style.fontSize = '${size}px';
    _timeInput.style.fontSize = '${size}px';
  }

  int get fontSize => _fontSize;

  void onChange(Function(Event event) listener) {
    _dateInput.onChange.listen((e) {
      listener(e);
    });
    _timeInput.onChange.listen((e) {
      listener(e);
    });
  }

  String get textAlign => _currentInput().style.textAlign;

  set textAlign(String value) => _currentInput().style.textAlign = value;

  void showTime() {
    _showTime = true;
    nodeRoot.children.remove(_dateInput);
    nodeRoot.children.add(_timeInput);
  }

  @override
  DateTime get value {
    if (_showTime) {
      return DateTime.fromMillisecondsSinceEpoch(
          (_timeInput.valueAsNumber ?? 0).ceil(),
          isUtc: true);
    } else {
      return _dateInput.valueAsDate;
    }
  }

  @override
  set value(DateTime value) {
    var newValue = '';
    if (_showTime) {
      newValue = formatDateTimeText(value);
      _timeInput.value = newValue;
    } else {
      newValue = formatDate(value);
      _dateInput.value = newValue;
    }
  }

  String getStringValue() {
    if (_showTime) {
      return formatDateTime(value);
    } else {
      return formatDate(value);
    }
  }

  @override
  void focus() {
    _currentInput().focus();
  }

  static String formatDate(DateTime date) => '${date.year.toString()}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';

  static String formatDateTime(DateTime date) => '${date.year.toString()}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')} '
      '${date.hour.toString().padLeft(2, '0')}:'
      '${date.minute.toString().padLeft(2, '0')}:'
      '${date.second.toString().padLeft(2, '0')}';

  static String formatDateTimeText(DateTime date) =>
      date.toIso8601String().substring(0, 16);
}
