import 'dart:async';
import 'dart:html';

import '../widgets.dart';

class BlockStateLabel {
  BlockStateLabel() {
    backgroundElement.style
      ..width = '100%'
      ..height = '100%'
      ..background = 'black'
      ..opacity = '0.8'
      ..display = 'block'
      ..left = '0'
      ..top = '0'
      ..position = 'absolute'
      ..flexDirection = 'column'
      ..justifyContent = 'center'
      ..alignItems = 'center'
      ..zIndex = '10';
    labelElement.style
      ..display = 'flex'
      ..width = '100%'
      ..color = 'white'
      ..padding = '5px'
      ..opacity = '1'
      ..justifyContent = 'center'
      ..textAlign = 'center'
      ..flexDirection = 'column'
      ..marginBottom = '25px';
    retryButton = SimpleButton()
      ..caption = 'Retry'
      ..width = '30%'
      ..nodeRoot.style.marginBottom = '5px';
    cancelButton
      ..width = '30%'
      ..caption = 'Cancel'
      ..type = SimpleButtonType.warrning
      ..nodeRoot.style.marginBottom = '5px';
    backgroundElement.onClick.listen((e) {
      retryCompleter?.complete(false);
      retryCompleter = null;
      hide();
    });
    cancelButton.onClick((e) {
      retryCompleter?.complete(false);
      retryCompleter = null;
      hide();
    });
    retryButton!.onClick((e) {
      retryCompleter?.complete(true);
      retryCompleter = null;
      hide();
    });
    backgroundElement.children.add(labelElement);
    backgroundElement.children.add(retryButton!.nodeRoot);
    backgroundElement.children.add(cancelButton.nodeRoot);
  }

  DivElement backgroundElement = DivElement()
    ..setAttribute('classname', 'BlockStateLabel');
  DivElement labelElement = DivElement();

  SimpleButton? retryButton;
  SimpleButton cancelButton = SimpleButton();

  Completer<bool>? retryCompleter;

  void showText(String message) {
    backgroundElement.style.display = 'flex';
    labelElement.text = message;
    retryButton?.visible = false;
    cancelButton.visible = false;
  }

  Future<bool> showTextWaitRetry(String message) {
    backgroundElement.style.display = 'flex';
    labelElement.text = message;
    retryButton?.visible = true;
    cancelButton.visible = true;
    retryCompleter = Completer<bool>();
    return retryCompleter!.future;
  }

  void hide() {
    backgroundElement.style.display = 'none';
  }

  set caption(String newCaption) => labelElement.text = newCaption;
  String get caption => labelElement.text ?? '';
}
