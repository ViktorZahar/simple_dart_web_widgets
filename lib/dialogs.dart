import 'dart:async';

import 'labels/simple_label.dart';
import 'modal_state_panel.dart';
import 'panel.dart';

abstract class AbstractDialog<T> extends PanelComponent {
  AbstractDialog(String className) : super('DialogWindow') {
    addCssClass(className);
  }

  Completer<T> completer = Completer<T>();

  final StreamController<String> _onClose = StreamController<String>();

  Stream<String> get onClose => _onClose.stream;
  bool closable = true;

  Future<T> showDialog() {
    completer = Completer<T>();
    beforeShow();
    modalStatePanel
      ..onClick.listen((event) {
        if (closable) {
          closeDialog();
        }
      })
      ..clear()
      ..add(this)
      ..visible = true;
    return completer.future;
  }

  void closeDialog() {
    modalStatePanel.visible = false;
    _onClose.sink.add('Close');
  }

  void destroy() {
    _onClose.close();
  }

  void beforeShow() {}
}

abstract class SimpleDialogLayout<T> extends AbstractDialog<T> {
  SimpleDialogLayout() : super('SimpleDialogLayout') {
    vertical = true;
    headerPanel.add(headerLabel);
    addAll([headerPanel, bodyPanel, footerPanel]);
  }

  String get caption => headerLabel.caption;

  set caption(String newCaption) {
    headerLabel.caption = newCaption;
  }

  Panel headerPanel = Panel()
    ..addCssClass('SimpleDialogLayoutHeader');
  SimpleLabel headerLabel = SimpleLabel();
  Panel bodyPanel = Panel()
    ..addCssClass('SimpleDialogLayoutBody');
  Panel footerPanel = Panel()
    ..addCssClass('SimpleDialogLayoutFooter');
}
