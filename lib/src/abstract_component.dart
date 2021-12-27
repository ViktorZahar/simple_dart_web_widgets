import 'dart:html';

typedef ValueChangeListener<T> = Function(T oldValue, T newValue);

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

  set borderRadius(String borderRadius) {
    nodeRoot.style.borderRadius = borderRadius;
  }

  String get borderRadius => nodeRoot.style.borderRadius;

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

  void wrap() {
    nodeRoot.style.flexWrap = 'wrap';
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

mixin Field<T> {
  List<ValueChangeListener<T>> onValueChangeListeners = <ValueChangeListener<T>>[];

  T get value;

  set value(T value);

  void focus();

  void onValueChange(ValueChangeListener<T> listener) {
    onValueChangeListeners.add(listener);
  }

  void clearValueChange() {
    onValueChangeListeners.clear();
  }

  void fireValueChange(T oldValue, T newValue) {
    for (final listener in onValueChangeListeners) {
      listener(oldValue, newValue);
    }
  }
}
