
List<String> listFromJson(List listObject) {
  final ret = <String>[];
  if (listObject != null) {
    for (final val in listObject) {
      ret.add(val.toString());
    }
  }

  return ret;
}
