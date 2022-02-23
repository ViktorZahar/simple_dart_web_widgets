import 'dart:html';

import 'abstract_component.dart';

class FileChooser extends Component {
  FileChooser() : super('FileChooser') {
    nodeRoot.children.add(_fileUploadInputElement);
  }

  @override
  Element nodeRoot = DivElement();
  final _fileUploadInputElement = FileUploadInputElement();

  File getCurrentFile() => _fileUploadInputElement.files!.first;

  String get caption => _fileUploadInputElement.title ?? '';

  set caption(String newVal) => _fileUploadInputElement.title = newVal;
}
