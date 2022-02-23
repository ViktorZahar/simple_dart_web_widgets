import 'dart:html';

import 'abstract_component.dart';

abstract class PanelComponent extends Component {
  PanelComponent(String className) : super(className) {
    nodeRoot.style
      ..display = 'flex'
      ..flexShrink = '0'
      ..flexGrow = '0'
      ..overflow = 'hidden'
      ..flexDirection = 'row';
  }

  @override
  DivElement nodeRoot = DivElement();

  List<Component> children = [];
  String _stride = '0px';
  bool _vertical = false;
  bool _scrollable = false;
  String _align = 'stretch';

  void add(Component component) {
    children.add(component);
    nodeRoot.children.add(component.nodeRoot);
    stride = _stride;
  }

  void insert(int index, Component component) {
    children.insert(index, component);
    nodeRoot.children.insert(index, component.nodeRoot);
    stride = _stride;
  }

  void addAll(List<Component> components) {
    for (final comp in components) {
      children.add(comp);
      nodeRoot.children.add(comp.nodeRoot);
    }
    stride = _stride;
  }

  void removeComponent(Component component) {
    children.remove(component);
    nodeRoot.children.remove(component.nodeRoot);
    stride = _stride;
  }

  void clear() {
    nodeRoot.children.clear();
    children.clear();
  }

  bool get vertical => _vertical;

  set vertical(bool _newVal) {
    if (_vertical == _newVal) {
      return;
    }
    _vertical = _newVal;
    if (_vertical) {
      nodeRoot.style.flexDirection = 'column';
    } else {
      nodeRoot.style.flexDirection = 'row';
    }

    stride = _stride;
    scrollable = _scrollable;
  }

  String get stride => _stride;

  set stride(String _newVal) {
    if (_stride == _newVal && _stride == '0px') {
      return;
    }
    _stride = _newVal;
    for (var i = 0; i < children.length; i++) {
      final child = children[i];
      final isLast = i == (children.length - 1);
      if (_vertical) {
        if (!isLast) {
          child.nodeRoot.style.marginBottom = _stride;
        } else {
          child.nodeRoot.style.marginBottom = '0';
        }
        if (wrap) {
          child.nodeRoot.style.marginRight = _stride;
        } else {
          child.nodeRoot.style.marginRight = '0';
        }
      } else {
        if (!isLast) {
          child.nodeRoot.style.marginRight = _stride;
        } else {
          child.nodeRoot.style.marginRight = '0';
        }

        if (wrap) {
          child.nodeRoot.style.marginBottom = _stride;
        } else {
          child.nodeRoot.style.marginBottom = '0';
        }
      }
    }
  }

  bool get scrollable => _scrollable;

  set scrollable(bool _newVal) {
    _scrollable = _newVal;
    if (_scrollable) {
      if (_vertical) {
        nodeRoot.style.overflowY = 'scroll';
      } else {
        nodeRoot.style.overflowX = 'scroll';
      }
    } else {
      if (_vertical) {
        nodeRoot.style.overflowY = 'hidden';
      } else {
        nodeRoot.style.overflowX = 'hidden';
      }
    }
  }

  String get align => _align;

  set align(String newAlign) {
    _align = newAlign;
    nodeRoot.style.alignItems = newAlign;
  }
}

class Panel extends PanelComponent {
  Panel() : super('Panel');
}
