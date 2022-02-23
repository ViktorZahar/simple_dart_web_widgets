import 'dart:async';

import 'labels/simple_label.dart';
import 'modal_state_panel.dart';
import 'panel.dart';

class ContextMenu {
  ContextMenu();

  Panel menuPanel = Panel()
    ..addCssClass('ContextMenu')
    ..vertical = true;

  Completer<String> completer = Completer<String>();

  Future<String> showContextMenu(List<String> actions, num x, num y) {
    completer = Completer();
    modalStatePanel.onClick.listen((event) {
      modalStatePanel.visible = false;
    });
    menuPanel.clear();
    for (final action in actions) {
      final actionElement = SimpleLabel()
        ..addCssClass('ContextMenuAction')
        ..caption = action;
      actionElement.nodeRoot.onClick.listen((event) {
        completer.complete(action);
        closeMenu();
      });
      menuPanel.add(actionElement);
    }
    menuPanel.nodeRoot.style
      ..top = '${y}px'
      ..left = '${x}px';
    modalStatePanel
      ..add(menuPanel)
      ..visible = true;
    return completer.future;
  }

  void closeMenu() {
    modalStatePanel.visible = false;
  }
}
