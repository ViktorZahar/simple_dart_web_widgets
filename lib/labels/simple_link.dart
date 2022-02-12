import 'dart:html';

import '../abstract_component.dart';
import '../mixins.dart';

class SimpleLink extends Component with MixinActivate {
  SimpleLink();

  @override
  AnchorElement nodeRoot = AnchorElement()..style.textDecoration = 'None';
  ImageElement? imgElement;

  bool _newTab = false;
  bool _enabled = true;

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
      //TODO enable button
    } else {
      //TODO enable button
    }
  }

  @override
  List<Element> get activate => [nodeRoot];
}
