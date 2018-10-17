part of 'package:simple_dart_web_widgets/src/widgets.dart';

class ContextMenu {
  Completer<String> completer;

  DivElement backgroundElement = new DivElement();
  DivElement menuElement = new DivElement();

  ContextMenu() {
    backgroundElement.style
      ..width = '100%'
      ..height = '100%'
      ..background = 'black'
      ..opacity = '0.5'
      ..display = 'block'
      ..left = '0'
      ..top = '0'
      ..position = 'absolute';
    menuElement.style
      ..position = 'absolute'
      ..display = 'flex'
      ..background = 'white'
      ..padding = '5px'
      ..opacity = '1'
      ..flexDirection = 'column';
    backgroundElement.onClick.listen((e) {
      closeMenu();
    });
  }

  Future<String> showContextMenu(List<String> actions, num x, num y) {
    completer = new Completer();
    var body = window.document.querySelector("body");
    body.children.add(backgroundElement);
    menuElement.children.clear();
    actions.forEach((action) {
      DivElement actionElement = new DivElement();
      actionElement.text = action;
      actionElement.classes.add("selectable");
      actionElement.onClick.listen((event) {
        completer.complete(action);
        closeMenu();
      });
      menuElement.children.add(actionElement);
    });
    menuElement.style
      ..top = "${y}px"
      ..left = "${x}px";
    body.children.add(menuElement);
    return completer.future;
  }

  void closeMenu() {
    backgroundElement.remove();
    menuElement.remove();
  }
}
