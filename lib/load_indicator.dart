import 'dart:html';

import 'abstract_component.dart';

class LoadIndicator extends Component {
  LoadIndicator() : super('LoadIndicator');

  @override
  DivElement nodeRoot = DivElement();

  void show(Component component) {
    component.nodeRoot
      ..style.position = 'relative'
      ..children.add(nodeRoot);
  }

  void hide() {
    nodeRoot.remove();
  }
}
