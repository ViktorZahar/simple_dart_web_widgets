import 'dart:html';

import '../abstract_component.dart';

class SimpleImage extends Component {
  SimpleImage() : super('SimpleImage') {
    nodeRoot.style
      ..alignItems = _verticalAlign
      ..justifyContent = _horizontalAlign;
  }

  @override
  ImageElement nodeRoot = ImageElement();

  String _verticalAlign = 'center';
  String _horizontalAlign = 'left';

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

  set source(String newSource) {
    nodeRoot.src = newSource;
  }

  String get source => nodeRoot.src ?? '';
}
