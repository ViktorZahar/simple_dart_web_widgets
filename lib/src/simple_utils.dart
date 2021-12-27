
List<String> listFromJson(List listObject) {
  final ret = <String>[];
  for (final val in listObject) {
    ret.add(val.toString());
  }

  return ret;
}
