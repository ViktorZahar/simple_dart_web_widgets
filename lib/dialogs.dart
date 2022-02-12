import 'dart:async';
import 'dart:html';

import 'abstract_component.dart';
import 'hv_panel.dart';
import 'labels/simple_label.dart';
import 'modal_state_panel.dart';

abstract class DialogWindow<T> {
  DialogWindow() {
    captionPanel.add(captionLabel);
    dialog
      ..add(captionPanel)
      ..add(createDialogContent());
  }

  HVPanel dialog = HVPanel()
    ..addCssClass('DialogWindow')
    ..vertical = true;
  HVPanel captionPanel = HVPanel()..addCssClass('DialogCaption');
  SimpleLabel captionLabel = SimpleLabel();
  Completer<T>? completer;

  final StreamController<String> _onClose = StreamController<String>();

  Stream<String> get onClose => _onClose.stream;
  bool closable = true;

  Future showDialog() {
    completer = Completer<T>();
    captionLabel.caption = caption();
    modalStatePanel
      ..onClick.listen((event) {
        if (closable) {
          closeDialog();
        }
      })
      ..clear()
      ..add(dialog);
    center();
    modalStatePanel
      ..add(dialog)
      ..visible = true;
    return completer!.future;
  }

  void closeDialog() {
    modalStatePanel.visible = false;
    _onClose.sink.add('');
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
