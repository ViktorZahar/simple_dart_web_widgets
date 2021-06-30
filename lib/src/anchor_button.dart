import 'dart:html';

import '../widgets.dart';

class AnchorButton extends Component {
  AnchorButton() {
    dartClassName('AnchorButton');
    refreshDisplay();
  }

  @override
  AnchorElement nodeRoot = AnchorElement();
  SimpleButtonType _type = SimpleButtonType.noStyle;

  bool _enabled = true;

  bool _newTab = false;

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

  bool get newTab => _newTab;

  set newTab(bool value) {
    _newTab = value;
    if (value) {
      nodeRoot.target = '_blank';
    } else {
      nodeRoot.target = '';
    }
  }

  void refreshDisplay() {
    clearClasses();
    if (_enabled) {
      switch (_type) {
        case SimpleButtonType.basic:
          addCssClasses([WidgetsTheme.simpleButtonBasic]);
          break;
        case SimpleButtonType.warning:
          addCssClasses([WidgetsTheme.simpleButtonWarning]);
          break;
        case SimpleButtonType.noStyle:
          addCssClasses([WidgetsTheme.simpleButtonNoStyle]);
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
