import 'dart:html';

import '../widgets.dart';

class SimpleButton extends Component with MixinCaption, MixinClickable {
  SimpleButton() {
    dartClassName('SimpleButton');
    nodeRoot.children.add(nodeCaptionElement);
    _refreshDisplay();
    // height = '${WidgetsTheme.basicFieldSize}px';
  }

  @override
  Element nodeRoot = DivElement();
  @override
  SpanElement nodeCaptionElement = SpanElement();
  ImageElement imageElement = ImageElement();
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

  @override
  set caption(String caption) {
    super.caption = caption;
    if (caption.isEmpty && nodeRoot.children.contains(nodeCaptionElement)) {
      nodeRoot.children.remove(nodeCaptionElement);
    } else if (caption.isNotEmpty &&
        !nodeRoot.children.contains(nodeCaptionElement)) {
      nodeRoot.children.add(nodeCaptionElement);
    }
  }

  set imageSrc(String src) {
    imageElement.src = src;
    if (imageSrc.isEmpty && nodeRoot.children.contains(imageElement)) {
      nodeRoot.children.remove(imageElement);
    } else if (imageSrc.isNotEmpty &&
        !nodeRoot.children.contains(imageElement)) {
      nodeRoot.children.add(imageElement);
    }
    imageElement.style.width = width;
  }

  String get imageSrc => imageElement.src ?? '';

  void _refreshDisplay() {
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

enum SimpleButtonType { basic, warning, noStyle }
