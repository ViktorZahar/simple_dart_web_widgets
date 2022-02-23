import 'dart:async';

import 'modal_state_panel.dart';
import 'panel.dart';

abstract class AbstractDialog<T> {
  AbstractDialog() {
    dialogWindow = createDialogWindow()..addCssClass('DialogWindow');
  }

  late PanelComponent dialogWindow;
  Completer<T>? completer;

  final StreamController<String> _onClose = StreamController<String>();

  Stream<String> get onClose => _onClose.stream;
  bool closable = true;

  Future<T> showDialog() {
    completer = Completer<T>();
    modalStatePanel
      ..onClick.listen((event) {
        if (closable) {
          closeDialog();
        }
      })
      ..clear()
      ..add(dialogWindow)
      ..visible = true;
    return completer!.future;
  }

  void closeDialog() {
    modalStatePanel.visible = false;
    _onClose.sink.add('');
  }

  void remove() {
    _onClose.close();
  }

  PanelComponent createDialogWindow();
}
