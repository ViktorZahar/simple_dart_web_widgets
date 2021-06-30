import 'dart:html';

import '../../widgets.dart';

class SimpleLabel extends Component {
  SimpleLabel() {
    nodeRoot.style
      ..flexShrink = '0'
      ..alignItems = _verticalAlign
      ..justifyContent = _horizontalAlign;
  }

  @override
  Element nodeRoot = DivElement();

  int _fontSize = 15;

  String _verticalAlign = 'center';
  String _horizontalAlign = 'left';

  set fontSize(int size) {
    _fontSize = size;
    nodeRoot.style.fontSize = '${size}px';
  }

  int get fontSize => _fontSize;

  set caption(String caption) => nodeRoot.text = caption;

  String get caption => nodeRoot.text ?? '';

  String get verticalAlign => _verticalAlign;

  set verticalAlign(String align) {
    if (_verticalAlign != align) {
      _verticalAlign = align;
      nodeRoot.style.alignItems = _verticalAlign;
    }
  }

  String get horizontalAlign => _horizontalAlign;

  set horizontalAlign(String align) {
    if (_horizontalAlign != align) {
      _horizontalAlign = align;
      nodeRoot.style.justifyContent = _horizontalAlign;
    }
  }

  wrap() {
    nodeRoot.style.wordWrap = 'anywhere';
  }
}
