import 'dart:async';
import 'dart:html';

import 'hv_panel.dart';

ModalStatePanel modalStatePanel = ModalStatePanel();

class ModalStatePanel extends HVPanel {
  ModalStatePanel() {
    visible = false;
    align = 'center';
    vertical = true;
    nodeRoot.onClick.listen((e) {
      if (e.target == nodeRoot) {
        _onClick.sink.add(e);
      }
    });
  }

  StreamController<MouseEvent> _onClick = StreamController<MouseEvent>();

  Stream<MouseEvent> get onClick => _onClick.stream;

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
        _onClick.sink.close();
        _onClick = StreamController<MouseEvent>();
      }
    }
  }
}
