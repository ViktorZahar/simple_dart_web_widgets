import 'dart:html';

import '../../widgets.dart';

class SimpleLink extends Component {
  SimpleLink();

  @override
  AnchorElement nodeRoot = AnchorElement()..style.textDecoration = 'None';
  ImageElement? imgElement;

  bool _newTab = false;
  bool _enabled = true;
  SimpleButtonType _type = SimpleButtonType.noStyle;

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

  set type(SimpleButtonType value) {
    _type = value;
    refreshDisplay();
  }

  SimpleButtonType get type => _type;

  set caption(String caption) => nodeRoot.text = caption;

  String get caption => nodeRoot.text ?? '';

  set href(String href) => nodeRoot.href = href;

  String get href => nodeRoot.href ?? '';

  set image(String imgPath) {
    if (imgElement == null) {
      imgElement = ImageElement(src: imgPath);
      nodeRoot.children.add(imgElement!);
    }
  }

  String get image => imgElement?.src ?? '';

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
}
