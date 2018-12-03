import 'dart:html';

abstract class MixinCaption {
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

abstract class MixinClickable {
  Element get nodeRoot;
  bool get enabled;
  void onClick(listener(MouseEvent event)) {
    nodeRoot.onClick.listen((e) {
      if (enabled) {
        listener(e);
      }
    });
  }
}
