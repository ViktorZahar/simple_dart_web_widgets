import 'dart:html';

import '../../widgets.dart';

class ComboboxField extends Component with Field<String> {
  ComboboxField() {
    nodeRoot.setAttribute('Name', 'ComboboxField');
    nodeRoot.style.display = 'flex';
    nodeRoot.children.add(_selectElement);
    addCssClasses([WidgetsTheme.comboboxField]);

    nodeRoot.onChange.listen((event) {
      fireValueChange(value, value);
    });
  }

  @override
  DivElement nodeRoot = DivElement();
  final SelectElement _selectElement = SelectElement();

  @override
  String get value => _selectElement.options[_selectElement.selectedIndex].text;

  @override
  set value(String value) => {};

  @override
  void focus() {
    _selectElement.focus();
  }

  void initOptions(List<String> options) {
    for (final option in options) {
      final optionElement = OptionElement()..text = option;
      _selectElement.append(optionElement);
    }
  }
}
