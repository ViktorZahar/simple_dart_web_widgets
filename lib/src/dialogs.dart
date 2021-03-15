import 'dart:async';
import 'dart:html';

import '../widgets.dart';

abstract class DialogWindow<T> {
  DialogWindow() {
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
      if (closable) {
        closeDialog();
      }
    });
    dialogElement.style
      ..position = 'absolute'
      ..display = 'flex'
      ..background = 'white'
      ..padding = '5px'
      ..opacity = '1'
      ..flexDirection = 'column';
    buttonsPanelElement.style
      ..width = '100%'
      ..flexDirection = 'row';

    dialogElement.children.add(captionElement);
    dialogElement.children.add(buttonsPanelElement);
    dialogElement.children.add(createDialogContent().nodeRoot);
  }

  DivElement backgroundElement = DivElement();
  DivElement dialogElement = DivElement();
  DivElement captionElement = DivElement();
  DivElement buttonsPanelElement = DivElement();
  Completer<T>? completer;
  Function()? onCloseListener;
  bool closable = true;

  Future showDialog() {
    completer = Completer<T>();
    final bodyElement = window.document.querySelector('body')!;
    captionElement.text = caption();
    bodyElement.children.add(backgroundElement);
    bodyElement.children.add(dialogElement);

    center();
    return completer!.future;
  }

  void closeDialog() {
    backgroundElement.remove();
    dialogElement.remove();
    if (onCloseListener != null) {
      onCloseListener!();
    }
  }

  void center() {
    final windowWidth = window.innerWidth!;
    final windowHeight = window.innerHeight!;
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
