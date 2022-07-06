import 'dart:async';
import 'dart:html';

class ValueChangeEvent<T> {
  ValueChangeEvent(this.oldValue, this.newValue);

  late T oldValue;
  late T newValue;
}

abstract class Component {
  Component(this.className) {
    setCssClass(className);
  }

  Element get nodeRoot;

  bool _visible = true;
  bool _warp = false;
  bool _fillContent = false;
  late String className;

  set varName(String varName) {
    nodeRoot.setAttribute('varName', varName);
  }

  String get varName => nodeRoot.getAttribute('varName') ?? '';

  bool get fillContent => _fillContent;

  set fillContent(bool newVal) {
    _fillContent = newVal;
    if (_fillContent) {
      nodeRoot.style.flex = '1';
    } else {
      nodeRoot.style.flex = '';
    }
  }

  void clearClasses() {
    nodeRoot.classes.clear();
  }

  bool get visible => _visible;

  set visible(bool _newVisible) {
    if (_visible != _newVisible) {
      _visible = _newVisible;
      if (_newVisible) {
        nodeRoot.style.display = 'flex';
      } else {
        nodeRoot.style.display = 'none';
      }
    }
  }

  set width(String _newWidth) {
    nodeRoot.style.width = _newWidth;
  }

  String get width => nodeRoot.style.width;

  set height(String _newHeight) {
    nodeRoot.style.height = _newHeight;
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

  bool get wrap => _warp;

  set wrap(bool _newVal) {
    _warp = _newVal;
    if (_warp) {
      nodeRoot.style.flexWrap = 'wrap';
    } else {
      nodeRoot.style.flexWrap = 'nowrap';
    }
  }

  set padding(String padding) => nodeRoot.style.padding = padding;

  String get padding =>
      (nodeRoot.style.padding.isEmpty) ? '0px' : nodeRoot.style.padding;

  void addCssClasses(List<String> classNames) {
    nodeRoot.classes.addAll(classNames);
  }

  void addCssClass(String className) {
    nodeRoot.classes.add(className);
  }

  void setCssClass(String className) {
    nodeRoot.classes
      ..clear()
      ..add(className);
  }

  void removeCssClasses(List<String> className) {
    nodeRoot.classes.removeAll(className);
  }

  void removeCssClass(String className) {
    nodeRoot.classes.remove(className);
  }

  void remove() {
    nodeRoot.remove();
  }

  Future<void> waitForReady() async {
    await Future.delayed(const Duration(milliseconds: 280));
  }
}

mixin Field<T> {
  final StreamController<ValueChangeEvent<T>> _onValueChange =
      StreamController<ValueChangeEvent<T>>.broadcast();

  Stream<ValueChangeEvent<T>> get onValueChange => _onValueChange.stream;

  T get value;

  set value(T value);

  String state = '';

  void focus();

  void fireValueChange(T oldValue, T newValue) {
    _onValueChange.sink.add(ValueChangeEvent(oldValue, newValue));
  }

  void closeStream() {
    _onValueChange.close();
  }
}

mixin UrlStateComponent<T> {
  Stream<ValueChangeEvent<T>> get onValueChange;

  String varName = '';

  String urlState = '';
}
