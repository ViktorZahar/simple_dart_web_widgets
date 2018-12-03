import 'dart:html';

import 'package:simple_dart_web_widgets/widgets.dart';

class FileChooser extends Component {
  
  FileChooser() {
    _fileUploadInputElement.title = 'book';
    nodeRoot.children.add(_fileUploadInputElement);
  }
  
  @override
  Element nodeRoot = DivElement();
  final _fileUploadInputElement = FileUploadInputElement();

  File getCurrentFile() => _fileUploadInputElement.files.first;
}
