import 'dart:html';

class BlockStateLabel {
  BlockStateLabel() {
    backgroundElement = DivElement();
    backgroundElement.style
      ..width = '100%'
      ..height = '100%'
      ..background = 'black'
      ..opacity = '0.8'
      ..display = 'block'
      ..left = '0'
      ..top = '0'
      ..position = 'absolute';
    labelElement = DivElement();
    labelElement.style
      ..position = 'absolute'
      ..display = 'flex'
      ..width = '100%'
      ..height = '100%'
      ..color = 'white'
      ..padding = '5px'
      ..opacity = '1'
      ..justifyContent = 'center'
      ..textAlign = 'center'
      ..flexDirection = 'column';
    backgroundElement.children.add(labelElement);
  }

  DivElement backgroundElement;
  DivElement labelElement;

  void show() {
    backgroundElement.style.display = 'flex';
  }

  void hide() {
    backgroundElement.style.display = 'none';
  }

  set caption(String newCaption) => labelElement.text = newCaption;
  String get caption => labelElement.text;
}
