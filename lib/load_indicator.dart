import 'hv_panel.dart';
import 'labels/simple_image.dart';

class LoadIndicator {
  SimpleImage? _image;

  void loadIndicatorShow(HVPanel hvPanel) {
    if (_image == null) {
      _image = SimpleImage()..addCssClass('LoadIndicator');
      _image ??= SimpleImage()..source = 'images/load_indicator.gif';
    }
  }

  void loadIndicatorHide() {
    if (_image != null) {
      _image!.nodeRoot.remove();
      _image = null;
    }
  }
}
