extension StringUtil on String {
  String trimAll(){
    String value = trim();
    var singleSpaces = value.replaceAll(RegExp(r"\s+"), " ");
    return singleSpaces;
  }
}