import 'dart:html';

import '../abstract_component.dart';
import '../mixins.dart';
import '../panel.dart';

class RadioField extends PanelComponent
    with Field<String>, UrlStateComponent<String>, MixinDisable {
  RadioField() : super('RadioField') {
    wrap = true;
  }

  final List<RadioButtonInputElement> radioButtons = [];
  String groupName = '';

  @override
  String get value =>
      radioButtons.singleWhere((el) => el.checked ?? false).value ?? '';

  @override
  set value(String value) =>
      radioButtons.singleWhere((el) => el.value == value).checked = true;

  @override
  String get urlState => value;

  @override
  set urlState(String newValue) => value = newValue;

  void addRadioButton(String value, String text) {
    final rowPanel = Panel()..align = 'center';
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
  List<Element> get disableNodes => radioButtons;
}
