import 'dart:async';
import 'dart:html';

import '../widgets.dart';

class BlockStateLabel {
  BlockStateLabel() {
    backgroundElement = DivElement()
      ..setAttribute('classname', 'BlockStateLabel');
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
      ..zIndex='10';
    labelElement = DivElement();
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
    cancelButton = SimpleButton()
      ..width = '30%'
      ..caption = 'Cancel'
      ..type = SimpleButtonType.warrning
      ..nodeRoot.style.marginBottom = '5px';
    backgroundElement.onClick.listen((e) {
      if (retryCompleter != null) {
        retryCompleter.complete(false);
      }
      retryCompleter = null;
      hide();
    });
    cancelButton.onClick((e) {
      if (retryCompleter != null) {
        retryCompleter.complete(false);
      }
      retryCompleter = null;
      hide();
    });
    retryButton.onClick((e) {
      if (retryCompleter != null) {
        retryCompleter.complete(true);
      }
      retryCompleter = null;
      hide();
    });
    backgroundElement.children.add(labelElement);
    backgroundElement.children.add(retryButton.nodeRoot);
    backgroundElement.children.add(cancelButton.nodeRoot);
  }

  DivElement backgroundElement;
  DivElement labelElement;

  SimpleButton retryButton;
  SimpleButton cancelButton;

  Completer<bool> retryCompleter;

  void showText(String message) {
    backgroundElement.style.display = 'flex';
    labelElement.text = message;
    retryButton.visible = false;
    cancelButton.visible = false;
  }

  Future<bool> showTextWaitRetry(String message) {
    backgroundElement.style.display = 'flex';
    labelElement.text = message;
    retryButton.visible = true;
    cancelButton.visible = true;
    retryCompleter = Completer<bool>();
    return retryCompleter.future;
  }

  void hide() {
    backgroundElement.style.display = 'none';
  }

  set caption(String newCaption) => labelElement.text = newCaption;
  String get caption => labelElement.text;
}
