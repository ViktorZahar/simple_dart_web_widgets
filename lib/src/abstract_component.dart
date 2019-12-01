import 'dart:html';

abstract class Component {
  Element get nodeRoot;

  bool _stateVisible = true;

  bool get visible => _stateVisible;

  void varName(String varName) {
    nodeRoot.setAttribute('varName', varName);
  }

  void fillContent() {
    nodeRoot.style.flex = '1';
  }

  void dartClassName(String className) {
    nodeRoot.setAttribute('className', className);
  }

  void clearClasses() {
    nodeRoot.classes.clear();
  }

  set visible(bool visible) {
    if (_stateVisible != visible) {
      _stateVisible = visible;
      if (visible) {
        nodeRoot.style.display = 'flex';
      } else {
        nodeRoot.style.display = 'none';
      }
    }
  }

  set width(String width) {
    nodeRoot.style.width = width;
  }

  String get width => nodeRoot.style.width;

  set height(String height) {
    nodeRoot.style.height = height;
  }

  String get height => nodeRoot.style.height;

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

  void addCssClasses(List<String> className) {
    nodeRoot.classes.addAll(className);
  }

  void removeCssClasses(List<String> className) {
    nodeRoot.classes.removeAll(className);
  }
}

abstract class Composite {
  List<Component> get children;

  void add(Component component);
  void addAll(List<Component> components);
}

abstract class Field<T> {
  List<Function(T oldValue, T newValue)> onValueChangeListeners = [];

  T get value;

  set value(T value);

  void focus();

  void onValueChange(listener(T oldValue, T newValue)) {
    onValueChangeListeners.add(listener);
  }

  void clearValueChange() {
    onValueChangeListeners.clear();
  }

  void fireValueChange(T oldValue, T newValue) {
    for (var listener in onValueChangeListeners) {
      listener(oldValue, newValue);
    }
  }
}
