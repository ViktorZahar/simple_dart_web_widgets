import 'dart:html';

import '../../widgets.dart';

class RadioField extends Component with Field<String> {
  RadioField() {
    nodeRoot.setAttribute('Name', 'RadioField');
    nodeRoot.style.display = 'flex';
    addCssClasses([WidgetsTheme.radioField]);
  }

  @override
  final DivElement nodeRoot = DivElement();
  final List<RadioButtonInputElement> radioButtons = [];
  String groupName = '';

  @override
  String get value => radioButtons.singleWhere((el) => el.checked).value;

  @override
  set value(String value) =>
      radioButtons.singleWhere((el) => el.value == value).checked = true;

  void addRadioButton(String value, String text) {
    final radioButton = RadioButtonInputElement()
      ..value = value
      ..name = groupName;
    final label = LabelElement()
      ..style.paddingRight = '5px'
      ..text = text;
    radioButton.onChange.listen((ev) {
      fireValueChange(radioButton.value, value);
    });
    radioButtons.add(radioButton);
    nodeRoot.children.add(radioButton);
    nodeRoot.children.add(label);
  }

  @override
  void focus() {
    nodeRoot.focus();
  }
}
