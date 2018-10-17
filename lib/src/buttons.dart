part of 'package:simple_dart_web_widgets/src/widgets.dart';

class SimpleButton extends Component with MixinCaption, MixinClickable {
  Element nodeRoot = new DivElement();
  SpanElement nodeCaptionElement = new SpanElement();

  SimpleButton() {
    nodeRoot.setAttribute('Name', 'SimpleButton');
    addCssClasses([WidgetsTheme.simpleButton]);
    nodeRoot.children.add(nodeCaptionElement);
  }
}
