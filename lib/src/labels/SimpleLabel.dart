part of 'package:simple_dart_web_widgets/src/widgets.dart';

class SimpleLabel extends Component {
  Element nodeRoot = new DivElement();

  SimpleLabel() {}

  set caption(String caption) => nodeRoot.text = caption;

  String get caption => nodeRoot.text;
}
