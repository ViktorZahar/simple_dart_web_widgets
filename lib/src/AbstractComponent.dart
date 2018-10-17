part of 'package:simple_dart_web_widgets/src/widgets.dart';

abstract class Component {
  Element get nodeRoot;

  bool _stateVisible = true;

  bool get visible => _stateVisible;

  void varName(String varName) {
    nodeRoot.setAttribute("varName", varName);
  }

  fillContent() {
    nodeRoot.style.flex = '1';
  }

  void dartClassName(String className) {
    nodeRoot.setAttribute("className", className);
  }

  set visible(bool visible) {
    if (_stateVisible == visible) return;
    _stateVisible = visible;
    if (visible) {
      nodeRoot.style.display = 'flex';
    } else {
      nodeRoot.style.display = 'none';
    }
  }

  set width(String width) {
    nodeRoot.style.width = width;
  }

  set height(String height) {
    nodeRoot.style.height = height;
  }

  void fullSize() {
    width = '100%';
    height = '100%';
  }

  void fullWidth() {
    width = '100%';
  }

  void fullHeight() {
    height = '100%';
  }

  addCssClasses(List<String> className) {
    nodeRoot.classes.addAll(className);
  }

  removeCssClasses(List<String> className) {
    nodeRoot.classes.removeAll(className);
  }
}

abstract class Composite {
  List<Component> get children;

  void add(Component component);
  void addAll(List<Component> components);
}

abstract class Field<T> {
  T get value;

  set value(T value);

  focus();
}
