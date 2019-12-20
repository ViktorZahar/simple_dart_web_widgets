import '../../widgets.dart';

// ListSimpleLinks - лист ссылок
class ListSimpleLinks extends HVPanel {
  ListSimpleLinks() {
    dartClassName('ListSimpleLinks');
    vertical();
    setSpaceBetweenItems(5);
    setPadding(5);
  }

  SimpleLink createLink(String href, String caption) {
    final ret = SimpleLink()
      ..caption = caption
      ..href = '#$href';
    add(ret);
    return ret;
  }
}
