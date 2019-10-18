import 'dart:html';

import 'package:simple_dart_web_widgets/widgets.dart';

class Pager extends Component {
  Pager() {
    nodeRoot.setAttribute('Name', 'Pager');
    nodeRoot.style
      ..display = 'flex'
      ..flexShrink = '0'
      ..flexGrow = '0'
      ..justifyContent = 'center'
      ..flexDirection = 'row';
    nodeRoot.children.add(btnFirst.nodeRoot);
    nodeRoot.children.add(btnPrev.nodeRoot);
    nodeRoot.children.add(textElement.nodeRoot);
    nodeRoot.children.add(lblCount.nodeRoot);
    nodeRoot.children.add(btnNext.nodeRoot);
    nodeRoot.children.add(btnLast.nodeRoot);
    btnFirst.onClick((e) {
      pagable.openPage(1);
      refreshDisplay();
    });
    btnPrev.onClick((e) {
      if (pagable.currentPage > 1) {
        pagable.openPage(pagable.currentPage - 1);
        refreshDisplay();
      }
    });
    btnNext.onClick((e) {
      if (pagable.currentPage < pagable.pageCount) {
        pagable.openPage(pagable.currentPage + 1);
        refreshDisplay();
      }
    });
    btnLast.onClick((e) {
      pagable.openPage(pagable.pageCount);
      refreshDisplay();
    });
    textElement.onChange((e) {
      try {
        final newPageNum = int.parse(textElement.value);
        pagable.openPage(newPageNum);
        refreshDisplay();
      } on Exception catch (e) {
        print(e);
      }
    });
    fullSize();
    fillContent();
  }

  @override
  Element nodeRoot = DivElement();

  SimpleButton btnFirst = SimpleButton()..caption = '<<';
  SimpleButton btnPrev = SimpleButton()..caption = ' <';
  SimpleButton btnNext = SimpleButton()..caption = '> ';
  SimpleButton btnLast = SimpleButton()..caption = '>>';

  TextField textElement = TextField()
    ..fontSize = 12
    ..width = '35px'
    ..height = '15px';
  SimpleLabel lblCount = SimpleLabel()
    ..fontSize = 12
    ..caption = '/ 0';

  Pagable pagable;

  void bind(Pagable pagable) {
    this.pagable = pagable;
    refreshDisplay();
  }

  void refreshDisplay() {
    textElement.value = pagable.currentPage.toString();
    lblCount.caption = '/ ${pagable.pageCount}';
    btnFirst.enabled = pagable.currentPage != 1;
    btnLast.enabled = pagable.currentPage < pagable.pageCount;
    btnPrev.enabled = btnFirst.enabled;
    btnNext.enabled = btnLast.enabled;
  }
}

abstract class Pagable {
  int get pageCount;
  int get currentPage;
  void openPage(int i);
}
