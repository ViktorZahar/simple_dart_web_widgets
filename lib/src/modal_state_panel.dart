import 'panels.dart';

ModalStatePanel modalStatePanel = ModalStatePanel();

class ModalStatePanel extends HVPanel {
  ModalStatePanel() {
    visible = false;
    align = 'center';
    vertical();
    addCssClasses(['modalStatePanel']);
    nodeRoot.onClick.listen((e) {
      if (e.target == nodeRoot) {
        if (onClick != null) {
          onClick!();
        }
      }
    });
  }

  Function? onClick;

  bool _stateVisible = true;

  @override
  bool get visible => _stateVisible;

  @override
  set visible(bool visible) {
    if (_stateVisible != visible) {
      _stateVisible = visible;
      if (visible) {
        nodeRoot.style.display = 'flex';
      } else {
        nodeRoot.style.display = 'none';
        clear();
        onClick = null;
      }
    }
  }
}
