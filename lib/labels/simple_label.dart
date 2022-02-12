import 'dart:html';

import '../abstract_component.dart';
import '../mixins.dart';

class SimpleLabel extends Component with MixinClickable {
  SimpleLabel() {
    nodeRoot.style
      ..overflow = 'hidden'
      ..flexShrink = '0'
      ..alignItems = _verticalAlign
      ..justifyContent = _horizontalAlign;
  }

  @override
  Element nodeRoot = DivElement();

  String _verticalAlign = 'center';
  String _horizontalAlign = 'left';
  bool _wordBreak = false;

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

  bool get wordBreak => _wordBreak;

  set wordBreak(bool _newVal) {
    _wordBreak = _newVal;
    if (_wordBreak) {
      nodeRoot.style.wordBreak = 'break-all';
    } else {
      nodeRoot.style.wordBreak = 'normal';
    }
  }

  @override
  bool get enabled => true;
}
