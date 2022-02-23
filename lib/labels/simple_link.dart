import 'dart:html';

import '../abstract_component.dart';
import '../mixins.dart';

class SimpleLink extends Component with MixinActivate, MixinDisable {
  SimpleLink() : super('SimpleLink');

  @override
  AnchorElement nodeRoot = AnchorElement();

  bool _newTab = false;

  bool get newTab => _newTab;

  set newTab(bool value) {
    _newTab = value;
    if (value) {
      nodeRoot.target = '_blank';
    } else {
      nodeRoot.target = '';
    }
  }

  set caption(String caption) => nodeRoot.text = caption;

  String get caption => nodeRoot.text ?? '';

  set href(String href) => nodeRoot.href = href;

  String get href => nodeRoot.href ?? '';

  @override
  List<Element> get activate => [nodeRoot];

  @override
  List<Element> get disableNodes => [nodeRoot];
}
