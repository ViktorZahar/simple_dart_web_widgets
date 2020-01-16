import 'dart:html';

import '../../widgets.dart';

class RadioField extends HVPanel with Field<String> {
  RadioField() {
    dartClassName('RadioField');
    addCssClasses([WidgetsTheme.radioField]);
  }

  final List<RadioButtonInputElement> radioButtons = [];
  String groupName = '';

  @override
  String get value => radioButtons.singleWhere((el) => el.checked).value;

  @override
  set value(String value) =>
      radioButtons.singleWhere((el) => el.value == value).checked = true;

  void addRadioButton(String value, String text) {
    final rowPanel = HVPanel();
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
    rowPanel.nodeRoot.children.add(radioButton);
    rowPanel.nodeRoot.children.add(label);
    add(rowPanel);
  }

  @override
  void focus() {
    nodeRoot.focus();
  }
}
