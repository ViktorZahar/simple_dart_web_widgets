import 'dart:async';

import 'dart:html';

class ContextMenu {
  ContextMenu() {
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
      closeMenu();
    });
    menuElement = DivElement();
    menuElement.style
      ..position = 'absolute'
      ..display = 'flex'
      ..background = 'white'
      ..padding = '5px'
      ..opacity = '1'
      ..flexDirection = 'column';
  }

  Completer<String> completer;

  DivElement backgroundElement;
  DivElement menuElement;

  Future<String> showContextMenu(List<String> actions, num x, num y) {
    completer = Completer();
    final body = window.document.querySelector('body');
    body.children.add(backgroundElement);
    menuElement.children.clear();
    for (final action in actions) {
      final actionElement = DivElement()
        ..text = action
        ..classes.add('selectable')
        ..onClick.listen((event) {
          completer.complete(action);
          closeMenu();
        });
      menuElement.children.add(actionElement);
    }
    menuElement.style
      ..top = '${y}px'
      ..left = '${x}px';
    body.children.add(menuElement);
    return completer.future;
  }

  void closeMenu() {
    backgroundElement.remove();
    menuElement.remove();
  }
}
