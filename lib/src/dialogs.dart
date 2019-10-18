import 'dart:async';
import 'dart:html';

import 'package:simple_dart_web_widgets/widgets.dart';

abstract class DialogWindow<T> {
  DialogWindow() {
    backgroundElement = DivElement();

    backgroundElement.style
      ..width = '100%'
      ..height = '100%'
      ..background = 'black'
      ..opacity = '0.5'
      ..display = 'block'
      ..left = '0'
      ..top = '0'
      ..position = 'absolute';
    backgroundElement.onClick.listen((e) {
      closeDialog();
    });
    dialogElement = DivElement();
    dialogElement.style
      ..position = 'absolute'
      ..display = 'flex'
      ..background = 'white'
      ..padding = '5px'
      ..opacity = '1'
      ..flexDirection = 'column';
    buttonsPanelElement = DivElement();
    buttonsPanelElement.style
      ..width = '100%'
      ..flexDirection = 'row';

    captionElement = DivElement();
    dialogElement.children.add(captionElement);
    dialogElement.children.add(buttonsPanelElement);
    dialogElement.children.add(createDialogContent().nodeRoot);
  }

  DivElement backgroundElement;
  DivElement dialogElement;
  DivElement captionElement;
  DivElement buttonsPanelElement;
  Completer<T> compliter;
  Function() onCloseListener;

  Future showDialog() {
    final completer = Completer<T>();
    final bodyElement = window.document.querySelector('body');
    captionElement.text = caption();
    bodyElement.children.add(backgroundElement);
    bodyElement.children.add(dialogElement);

    center();
    return completer.future;
  }

  void closeDialog() {
    backgroundElement.remove();
    dialogElement.remove();
    if (onCloseListener != null) {
      onCloseListener();
    }
  }

  void center() {
    final windowWidth = window.innerWidth;
    final windowHeight = window.innerHeight;
    final dialogWidth = dialogElement.clientWidth;
    final dialogHeight = dialogElement.clientHeight;
    final x = (windowWidth - dialogWidth) / 2;
    final y = (windowHeight - dialogHeight) / 2;
    dialogElement.style
      ..top = '${y}px'
      ..left = '${x}px';
  }

  String caption();

  Component createDialogContent();
}
