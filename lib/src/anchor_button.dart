import 'dart:html';
import '../widgets.dart';

class AnchorButton extends Component {
  AnchorButton() {
    dartClassName('AnchorButton');
    refreshDisplay();
  }

  @override
  AnchorElement nodeRoot = AnchorElement();
  SimpleButtonType _type = SimpleButtonType.basic;

  bool _enabled = true;

  set type(SimpleButtonType value) {
    _type = value;
    refreshDisplay();
  }

  SimpleButtonType get type => _type;

  bool get enabled => _enabled;
  set enabled(bool value) {
    if (_enabled != value) {
      _enabled = value;
      refreshDisplay();
    }
  }

  void refreshDisplay() {
    clearClasses();
    if (_enabled) {
      switch (_type) {
        case SimpleButtonType.basic:
          addCssClasses([WidgetsTheme.simpleButtonBasic]);
          break;
        case SimpleButtonType.warrning:
          addCssClasses([WidgetsTheme.simpleButtonWarning]);
          break;
      }
    } else {
      addCssClasses([WidgetsTheme.simpleButtonDisabled]);
    }
  }

  set url(String url) => nodeRoot.href = url;

  String get url => nodeRoot.href ?? '';

  set caption(String text) => nodeRoot.text = text;

  String get caption => nodeRoot.text ?? '';
}
