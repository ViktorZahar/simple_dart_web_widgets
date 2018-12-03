import 'dart:html';

import 'package:simple_dart_web_widgets/widgets.dart';

class ComboboxField extends Component implements Field<String> {
  ComboboxField() {
    nodeRoot.setAttribute('Name', 'ComboboxField');
    nodeRoot.style.display = 'flex';
    nodeRoot.children.add(_selectElement);
    addCssClasses([WidgetsTheme.comboboxField]);
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
    for (var option in options) {
      final optionElement = OptionElement()..text = option;
      _selectElement.append(optionElement);
    }
  }
}
