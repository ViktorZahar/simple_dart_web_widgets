part of 'package:simple_dart_web_widgets/src/widgets.dart';

class ComboboxField extends Component implements Field<String> {
  DivElement nodeRoot = new DivElement();
  SelectElement _selectElement = new SelectElement();

  ComboboxField() {
    nodeRoot.setAttribute('Name', 'ComboboxField');
    addCssClasses([WidgetsTheme.comboboxField]);
    nodeRoot.style..display = 'flex';
    nodeRoot.children.add(_selectElement);
  }

  String get value {
    return _selectElement.options[_selectElement.selectedIndex].text;
  }

  set value(String value) => {};

  focus() {
    _selectElement.focus();
  }

  void initOptions(List<String> options) {
    options.forEach((String option) {
      OptionElement optionElement = new OptionElement();
      optionElement.text = option;
      _selectElement.append(optionElement);
    });
  }
}
