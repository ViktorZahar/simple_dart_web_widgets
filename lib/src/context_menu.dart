import 'dart:async';

import '../widgets.dart';
import 'panels.dart';

class ContextMenu {
  ContextMenu();

  HVPanel menuPanel = HVPanel()
    ..addCssClasses(['contextMenu'])
    ..width = ''
    ..vertical()
    ..setPadding(5);

  Completer<String> completer = Completer<String>();

  Future<String> showContextMenu(List<String> actions, num x, num y) {
    completer = Completer();
    modalStatePanel.onClick = () {
      modalStatePanel.visible = false;
    };
    menuPanel.clear();
    for (final action in actions) {
      final actionElement = SimpleLabel()
        ..caption = action
        ..addCssClasses(['selectable','contextMenuAction']);
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
