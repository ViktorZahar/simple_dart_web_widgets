import 'dart:html';

import '../widgets.dart';

class FileChooser extends Component {
  FileChooser() {
    nodeRoot.children.add(_fileUploadInputElement);
  }

  @override
  Element nodeRoot = DivElement();
  final _fileUploadInputElement = FileUploadInputElement();

  File getCurrentFile() => _fileUploadInputElement.files!.first;

  String get caption => _fileUploadInputElement.title ?? '';

  set caption(String newVal) => _fileUploadInputElement.title = newVal;
}
