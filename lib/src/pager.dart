import 'dart:html';

import '../widgets.dart';

class Pager extends Component {
  Pager() {
    dartClassName('Pager');
    nodeRoot.style
      ..display = 'flex'
      ..flexShrink = '1'
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
      pagable!.openPage(1);
      refreshDisplay();
    });
    btnPrev.onClick((e) {
      if (pagable!.currentPage > 1) {
        pagable!.openPage(pagable!.currentPage - 1);
        refreshDisplay();
      }
    });
    btnNext.onClick((e) {
      if (pagable!.currentPage < pagable!.pageCount) {
        pagable!.openPage(pagable!.currentPage + 1);
        refreshDisplay();
      }
    });
    btnLast.onClick((e) {
      pagable!.openPage(pagable!.pageCount);
      refreshDisplay();
    });
    textElement.onChange((e) {
      try {
        final newPageNum = int.parse(textElement.value);
        pagable!.openPage(newPageNum);
        refreshDisplay();
      } on Exception catch (_) {}
    });
    height = '25px';
    fullWidth();
  }

  @override
  Element nodeRoot = DivElement();

  SimpleButton btnFirst = SimpleButton()
    ..caption = '<<'
    ..nodeRoot.style.borderRadius = '0px';
  SimpleButton btnPrev = SimpleButton()
    ..caption = ' <'
    ..nodeRoot.style.borderRadius = '0px';
  SimpleButton btnNext = SimpleButton()
    ..caption = '> '
    ..nodeRoot.style.borderRadius = '0px';
  SimpleButton btnLast = SimpleButton()
    ..caption = '>>'
    ..nodeRoot.style.borderRadius = '0px';

  TextField textElement = TextField()
    ..fontSize = 12
    ..width = '35px'
    ..height = '19px'
    ..textAlign = 'center'
    ..nodeRoot.style.marginLeft = '5px'
    ..nodeRoot.style.marginRight = '5px';
  SimpleLabel lblCount = SimpleLabel()
    ..fontSize = 12
    ..height = '25px'
    ..caption = '/ 0'
    ..nodeRoot.style.paddingLeft = '5px'
    ..nodeRoot.style.paddingRight = '5px';

  Pagable? pagable;

  void bind(Pagable pagable) {
    this.pagable = pagable;
    refreshDisplay();
  }

  void refreshDisplay() {
    if (pagable != null) {
      textElement.value = pagable!.currentPage.toString();
      lblCount.caption = '/ ${pagable!.pageCount}';
      btnFirst.enabled = pagable!.currentPage != 1;
      btnLast.enabled = pagable!.currentPage < pagable!.pageCount;
      btnPrev.enabled = btnFirst.enabled;
      btnNext.enabled = btnLast.enabled;
    }
  }
}

abstract class Pagable {
  int get pageCount;
  int get currentPage;
  void openPage(int i);
}
