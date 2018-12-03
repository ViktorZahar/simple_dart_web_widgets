import 'dart:html';

import 'package:simple_dart_web_widgets/widgets.dart';

class HVPanel extends Component implements Composite {
  HVPanel() {
    nodeRoot.style
      ..display = 'flex'
      ..flexShrink = '0'
      ..flexGrow = '0'
      ..flexDirection = 'row';
    dartClassName('HVPanel');
    fullWidth();
  }

  @override
  Element nodeRoot = DivElement();
  @override
  List<Component> children = [];
  int _spaceBetweenItems = 0;
  bool _vertical = false;
  bool _scrollable = false;

  @override
  void add(Component component) {
    children.add(component);
    nodeRoot.children.add(component.nodeRoot);
    setSpaceBetweenItems(_spaceBetweenItems);
  }

  @override
  void addAll(List<Component> components) {
    for (var comp in components) {
      children.add(comp);
      nodeRoot.children.add(comp.nodeRoot);
    }
    setSpaceBetweenItems(_spaceBetweenItems);
  }

  void clear() {
    children.clear();
    nodeRoot.children.clear();
  }

  void vertical() {
    _vertical = true;
    nodeRoot.style.flexDirection = 'column';
    setSpaceBetweenItems(_spaceBetweenItems);
    if (_scrollable) {
      scrollable();
    }
  }

  void setSpaceBetweenItems(int space) {
    if (space == 0 && _spaceBetweenItems == 0) {
      return;
    }
    _spaceBetweenItems = space;
    for (var child in nodeRoot.children) {
      child.style
        ..marginBottom = '${space}px'
        ..marginRight = '${space}px';
    }
  }

  void setPadding(int padding) {
    nodeRoot.style.padding = '${padding}px';
  }

  void scrollable() {
    _scrollable = true;
    if (_vertical) {
      nodeRoot.style.overflowY = 'scroll';
    } else {
      nodeRoot.style.overflowX = 'scroll';
    }
  }
}
