part of 'package:simple_dart_web_widgets/src/widgets.dart';

class SimpleLink extends Component {
  AnchorElement nodeRoot;

  SimpleLink() {
    nodeRoot = new AnchorElement();
    nodeRoot.style..textDecoration = 'None';
  }

  set caption(String caption) => nodeRoot.text = caption;

  String get caption => nodeRoot.text;

  set href(String href) => nodeRoot.href = href;

  String get href => nodeRoot.href;
}
