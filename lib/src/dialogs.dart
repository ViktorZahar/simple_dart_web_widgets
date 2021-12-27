import 'dart:async';
import 'dart:html';

import '../widgets.dart';

abstract class DialogWindow<T> {
  DialogWindow() {
    captionPanel.add(captionLabel);
    dialog
      ..add(captionPanel)
      ..add(createDialogContent());
  }

  HVPanel dialog = HVPanel()
    ..addCssClasses(['dialogWindow'])
    ..vertical()
    ..width = '';
  HVPanel captionPanel = HVPanel()..addCssClasses(['dialogCaptionPanel']);
  SimpleLabel captionLabel = SimpleLabel();
  Completer<T>? completer;
  Function()? onCloseListener;
  bool closable = true;

  Future showDialog() {
    completer = Completer<T>();
    captionLabel.caption = caption();
    modalStatePanel
      ..onClick = () {
        if (closable) {
          closeDialog();
        }
      }
      ..clear()
      ..add(dialog);
    center();
    modalStatePanel.add(dialog);
    modalStatePanel.visible = true;
    return completer!.future;
  }

  void closeDialog() {
    modalStatePanel.visible = false;
    if (onCloseListener != null) {
      onCloseListener!();
    }
  }

  void center() {
    final windowWidth = window.innerWidth!;
    final windowHeight = window.innerHeight!;
    final dialogWidth = dialog.nodeRoot.clientWidth;
    final dialogHeight = dialog.nodeRoot.clientHeight;
    final x = (windowWidth - dialogWidth) / 2;
    final y = (windowHeight - dialogHeight) / 3;
    dialog.nodeRoot.style
      ..top = '${y}px'
      ..left = '${x}px';
  }

  String caption();

  Component createDialogContent();
}
