import 'dart:html';

import 'abstract_component.dart';
import 'mixins.dart';

class SimpleButton extends Component
    with MixinCaption, MixinActivate, MixinDisable {
  SimpleButton() : super('SimpleButton') {
    nodeRoot.style
      ..alignItems = 'center'
      ..justifyContent = 'center';
  }

  Stream<MouseEvent> get onClick =>
      nodeRoot.onClick.where((event) => !disabled);

  @override
  Element nodeRoot = DivElement();

  @override
  List<Element> get activate => [nodeRoot];

  @override
  List<Element> get disableNodes => [nodeRoot];

  @override
  Element get nodeCaptionElement => nodeRoot;
}
