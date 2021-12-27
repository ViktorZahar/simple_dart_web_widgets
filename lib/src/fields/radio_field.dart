import 'dart:html';

import '../../widgets.dart';

class RadioField extends HVPanel with Field<String>, MixinDisableable {
  RadioField() {
    dartClassName('RadioField');
    wrap();
    addCssClasses([WidgetsTheme.radioField]);
  }

  final List<RadioButtonInputElement> radioButtons = [];
  String groupName = '';

  @override
  String get value =>
      radioButtons.singleWhere((el) => el.checked ?? false).value ?? '';

  @override
  set value(String value) =>
      radioButtons.singleWhere((el) => el.value == value).checked = true;

  void addRadioButton(String value, String text) {
    final rowPanel = HVPanel()
      ..align = 'center'
      ..width = ''
      ..height = '${WidgetsTheme.basicFieldSize}px';
    final radioButton = RadioButtonInputElement()
      ..value = value
      ..name = groupName;
    final label = LabelElement()
      ..style.paddingLeft = '3px'
      ..style.paddingRight = '10px'
      ..text = text
      ..onClick.listen((e) {
        if (disabled) {
          return;
        }
        radioButton.checked = true;
      });
    radioButton.onChange.listen((ev) {
      fireValueChange(radioButton.value!, value);
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

  @override
  List<Element> get disableableNodes => radioButtons;
}
