part of 'package:simple_dart_web_widgets/src/widgets.dart';

class TextField extends Component implements Field<String> {
  DivElement nodeRoot = new DivElement();
  TextInputElement _textInput = new TextInputElement();

  TextField() {
    nodeRoot.style
      ..display = 'flex'
      ..textAlign = 'center'
      ..alignItems = 'center'
      ..justifyContent = 'center';

    _textInput.style
      ..fontSize = '16px'
      ..fontFamily = 'Cousine'
      ..flexGrow = '1';
    nodeRoot.children.add(_textInput);
  }

  get value => _textInput.value;

  set value(String value) => _textInput.value = value;

  focus() {
    _textInput.focus();
  }
}
