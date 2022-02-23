import 'dart:html';

mixin MixinCaption {
  String _stateCaption = '';

  Element get nodeCaptionElement;

  set caption(String caption) {
    if (_stateCaption != caption) {
      _stateCaption = caption;
      nodeCaptionElement.text = caption;
    }
  }

  String get caption => _stateCaption;
}

mixin MixinDisable {
  List<Element> get disableNodes;

  bool _disabled = false;

  bool get disabled => _disabled;

  set disabled(bool newVal) {
    _disabled = newVal;
    for (final element in disableNodes) {
      if (newVal) {
        element.setAttribute('disabled', '');
        element.classes.add('Disabled');
      } else {
        element.removeAttribute('disabled');
        element.classes.remove('Disabled');
      }
    }
  }

  bool get enabled => !disabled;

  set enabled(bool newVal) => disabled = !newVal;
}

mixin MixinActivate {
  List<Element> get activate;

  bool _active = false;

  bool get active => _active;

  set active(bool newVal) {
    _active = newVal;
    for (final element in activate) {
      if (newVal) {
        element.classes.add('Active');
      } else {
        element.classes.remove('Active');
      }
    }
  }
}
