extension ListExtensions on List<String> {
  String joinFirstTwo([String separator = ' / ']) {
    return take(2).join(separator);
  }

  List<String> removeEmpty() {
    final result = [...this];
    result.removeWhere((element) => element.isEmpty);
    return result;
  }
}
