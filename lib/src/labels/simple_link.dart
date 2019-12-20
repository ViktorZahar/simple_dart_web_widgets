import 'dart:html';

import '../../widgets.dart';

class SimpleLink extends Component {
  SimpleLink() {
    nodeRoot = AnchorElement();
    nodeRoot.style.textDecoration = 'None';
  }

  @override
  AnchorElement nodeRoot;

  set caption(String caption) => nodeRoot.text = caption;

  String get caption => nodeRoot.text;

  set href(String href) => nodeRoot.href = href;

  String get href => nodeRoot.href;
}
