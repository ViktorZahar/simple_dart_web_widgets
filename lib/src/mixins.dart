part of 'package:simple_dart_web_widgets/src/widgets.dart';

abstract class MixinCaption {
  String _stateCaption = '';
  int _stateFontSize = 10;
  Element get nodeCaptionElement;

  set caption(String caption) {
    if (_stateCaption == caption) return;
    _stateCaption = caption;
    nodeCaptionElement.text = caption;
  }

  get caption => _stateCaption;

  set fontSize(int fontSize) {
    _stateFontSize = fontSize;
    nodeCaptionElement.style.fontSize = '${fontSize}px';
  }

  get fontSize => _stateFontSize;
}

abstract class MixinClickable {
  Element get nodeRoot;
  void onClick(listener(event)) {
    nodeRoot.onClick.listen(listener);
  }
}
