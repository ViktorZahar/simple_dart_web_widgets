import 'dart:html';

import '../../widgets.dart';

class ComboboxField extends Component with Field<String>, MixinDisablable {
  ComboboxField() {
    dartClassName('ComboboxField');
    nodeRoot.style.display = 'flex';
    _selectElement.style
      ..fontSize = '16px'
      ..fontFamily = WidgetsTheme.basicFont;
    nodeRoot.children.add(_selectElement);
    addCssClasses([WidgetsTheme.comboboxField]);

    nodeRoot.onChange.listen((event) {
      fireValueChange(value, value);
    });
  }

  @override
  DivElement nodeRoot = DivElement();

  @override
  List<Element> get disablableNodes => [_selectElement];
  final SelectElement _selectElement = SelectElement();
  final List<String> optionList = <String>[];

  @override
  String get value {
    if (_selectElement.selectedIndex == -1 ||
        _selectElement.options.length < _selectElement.selectedIndex!) {
      return '';
    }
    return _selectElement.options[_selectElement.selectedIndex!].text ?? '';
  }


  @override
  set value(String newValue) {
    final oldValue = _selectElement.value ?? '';
    for (final option in _selectElement.options) {
      if (option.text?.toUpperCase() == newValue.toUpperCase()) {
        _selectElement.selectedIndex = option.index;
        break;
      }
    }
    fireValueChange(oldValue, value);
  }

  @override
  void focus() {
    _selectElement.focus();
  }

  void initOptions(List<String> options) {
    optionList.addAll(options);
    for (final option in _selectElement.options) {
      option.remove();
    }
    for (final option in options) {
      final optionElement = OptionElement()
        ..text = option;
      _selectElement.append(optionElement);
    }
  }

  set height(String height) {
    _selectElement.style.height = height;
  }

  set fontSize(String size) => _selectElement.style.fontSize = size;
}
