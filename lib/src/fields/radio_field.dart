import 'dart:html';

import 'package:simple_dart_web_widgets/widgets.dart';

class RadioField extends Component implements Field<String> {
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

    radioButtons.add(radioButton);
    nodeRoot.children.add(radioButton);
    nodeRoot.children.add(label);
  }

  @override
  void focus() {
    nodeRoot.focus();
  }
}
