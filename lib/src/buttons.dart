import 'dart:html';
import '../widgets.dart';

class SimpleButton extends Component with MixinCaption, MixinClickable {
  SimpleButton() {
    dartClassName('SimpleButton');
    nodeRoot.children.add(nodeCaptionElement);
    _refreshDisplay();
  }

  @override
  Element nodeRoot = DivElement();
  @override
  SpanElement nodeCaptionElement = SpanElement();
  SimpleButtonType _type = SimpleButtonType.basic;

  bool _enabled = true;

  set type(SimpleButtonType value) {
    _type = value;
    _refreshDisplay();
  }

  SimpleButtonType get type => _type;

  @override
  bool get enabled => _enabled;
  set enabled(bool value) {
    if (_enabled != value) {
      _enabled = value;
      _refreshDisplay();
    }
  }

  void _refreshDisplay() {
    clearClasses();
    if (_enabled) {
      switch (_type) {
        case SimpleButtonType.basic:
          addCssClasses([WidgetsTheme.simpleButtonBasic]);
          break;
        case SimpleButtonType.warrning:
          addCssClasses([WidgetsTheme.simpleButtonWarrning]);
          break;
      }
    } else {
      addCssClasses([WidgetsTheme.simpleButtonDisabled]);
    }
  }
}

enum SimpleButtonType { basic, warrning }
