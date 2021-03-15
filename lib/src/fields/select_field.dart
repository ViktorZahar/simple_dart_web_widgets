import 'dart:html';

import '../../widgets.dart';

class SelectField extends Component with Field<List<String>>, MixinDisablable {
  SelectField() {
    dartClassName('SelectField');
    nodeRoot.style.display = 'flex';
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
  final SelectElement _selectElement = SelectElement()..style.height = '100%';
  final List<String> optionList = <String>[];

  @override
  List<String> get value =>
      _selectElement.selectedOptions.map((so) => so.text!).toList();

  @override
  set value(List<String> newValue) {
    final oldValue =
        _selectElement.selectedOptions.map((so) => so.text!).toList();
    for (final option in _selectElement.options) {
      if (newValue.contains(option.text)) {
        option.selected = true;
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
      final optionElement = OptionElement()..text = option;
      _selectElement.append(optionElement);
    }
  }

  void selectAll() {
    print('selectAll');
    _selectElement.options.forEach((element) {
      element.selected = true;
    });
  }

  void unselectAll() {
    _selectElement.options.forEach((element) {
      element.selected = false;
    });
  }

  bool get multiple => _selectElement.multiple ?? false;
  set multiple(bool newVal) => _selectElement.multiple = newVal;

  int get size => _selectElement.size ?? 0;
  set size(int newVal) => _selectElement.size = newVal;
}
