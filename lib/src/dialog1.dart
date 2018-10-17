part of 'package:simple_dart_web_widgets/src/widgets.dart';

abstract class DialogWindow {
  DivElement backgroundElement = new DivElement();
  DivElement dialogElement = new DivElement();
  DivElement captionElement = new DivElement();
  DivElement buttonsPanelElement = new DivElement();
  Completer compliter;
  Component dialogContent;
  Function() onCloseListener;

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
      closeDialog();
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

    captionElement = new DivElement();
    buttonsPanelElement = new DivElement();
    dialogElement.children.add(captionElement);
    dialogElement.children.add(buttonsPanelElement);
    dialogElement.children.add(createDialogContent().nodeRoot);
  }

  Future showDialog() {
    var completer = new Completer();
    var body = window.document.querySelector("body");
    captionElement.text = caption();
    body.children.add(backgroundElement);

    body.children.add(dialogElement);

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
    var windowWidth = window.innerWidth;
    var windowHeight = window.innerHeight;
    var dialogWidth = dialogElement.clientWidth;
    var dialogHeight = dialogElement.clientHeight;
    var x = (windowWidth - dialogWidth) / 2;
    var y = (windowHeight - dialogHeight) / 2;
    dialogElement.style
      ..top = "${y}px"
      ..left = "${x}px";
  }

  String caption();

  Component createDialogContent();
}
