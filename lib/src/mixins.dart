import 'dart:html';

mixin MixinCaption {
  String _stateCaption = '';
  int _stateFontSize = 10;
  Element get nodeCaptionElement;

  set caption(String caption) {
    if (_stateCaption != caption) {
      _stateCaption = caption;
      nodeCaptionElement.text = caption;
    }
  }

  String get caption => _stateCaption;

  set fontSize(int fontSize) {
    _stateFontSize = fontSize;
    nodeCaptionElement.style.fontSize = '${fontSize}px';
  }

  int get fontSize => _stateFontSize;
}

mixin MixinClickable {
  Element get nodeRoot;
  bool get enabled;
  void onClick(Function(MouseEvent event) listener) {
    nodeRoot.onClick.listen((e) {
      if (enabled) {
        listener(e);
      }
    });
  }
}

mixin MixinDisableable {
  List<Element> get disableableNodes;
  bool _disabled = false;
  bool get disabled => _disabled;

  set disabled(bool newVal) {
    _disabled = newVal;
    for (final element in disableableNodes) {
      if (newVal) {
        element.setAttribute('disabled', '');
      } else {
        element.removeAttribute('disabled');
      }
    }
  }
}
