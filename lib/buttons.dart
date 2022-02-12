import 'dart:html';

import 'abstract_component.dart';
import 'mixins.dart';

class SimpleButton extends Component
    with MixinCaption, MixinClickable, MixinActivate {
  SimpleButton() {
    nodeRoot.children.add(nodeCaptionElement);
    _refreshDisplay();
  }

  @override
  Element nodeRoot = DivElement();
  @override
  SpanElement nodeCaptionElement = SpanElement();
  ImageElement imageElement = ImageElement();

  bool _enabled = true;

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
    if (_enabled) {
      //TODO enable button
    } else {
      //TODO disable button
    }
  }

  @override
  List<Element> get activate => [nodeRoot];
}
