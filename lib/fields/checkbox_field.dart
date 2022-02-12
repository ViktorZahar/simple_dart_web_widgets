import 'dart:html';

import '../abstract_component.dart';
import '../mixins.dart';


class CheckboxField extends Component with Field<bool>, MixinDisable {
  CheckboxField() {
    addCssClass('checkBox');
    nodeRoot.style
      ..display = 'flex'
      ..textAlign = 'center'
      ..justifyContent = 'left'
      ..alignItems = 'center';

    _checkBoxInput.onChange.listen((event) {
      fireValueChange(value, value);
    });
    _checkBoxInput.style
      ..width = '18px'
      ..height = '18px';

    nodeRoot.children.add(_checkBoxInput);
    nodeRoot.children.add(_label);
  }

  @override
  DivElement nodeRoot = DivElement();

  @override
  List<Element> get disableNodes => [_checkBoxInput];
  final CheckboxInputElement _checkBoxInput = CheckboxInputElement();
  final LabelElement _label = LabelElement()..style.paddingRight = '5px';

  @override
  set width(String width) {
    _checkBoxInput.style.width = width;
    nodeRoot.style.width = width;
  }

  @override
  set height(String height) {
    _checkBoxInput.style.height = height;
    nodeRoot.style.height = height;
  }
  void onChange(Function(Event event) listener) {
    _checkBoxInput.onChange.listen((e) {
      listener(e);
    });
  }

  @override
  bool get value => _checkBoxInput.checked ?? false;

  @override
  set value(bool value) {
    final oldValue = _checkBoxInput.checked ?? false;
    _checkBoxInput.checked = value;
    fireValueChange(oldValue, value);
  }

  set caption(String caption) => _label.text = caption;

  String get caption => _label.text ?? '';

  @override
  void focus() {
    _checkBoxInput.focus();
  }
}
