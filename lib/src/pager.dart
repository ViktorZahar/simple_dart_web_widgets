import '../widgets.dart';

class Pager extends HVPanel {
  Pager() {
    dartClassName('Pager');
    add(btnFirst);
    add(btnPrev);
    add(textElement);
    add(lblCount);
    add(btnNext);
    add(btnLast);
    setSpaceBetweenItems(1);
    align = 'center';
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
  }

  SimpleButton btnFirst = SimpleButton()
    ..fullHeight()
    ..caption = '<<';
  SimpleButton btnPrev = SimpleButton()
    ..fullHeight()
    ..caption = ' <';
  SimpleButton btnNext = SimpleButton()
    ..fullHeight()
    ..caption = '> ';
  SimpleButton btnLast = SimpleButton()
    ..fullHeight()
    ..caption = '>>';

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
