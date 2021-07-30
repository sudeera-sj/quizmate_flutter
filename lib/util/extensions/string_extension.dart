extension StringExtension on String {
  String get capitalize {
    return this.length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
  }

  String get capitalizeFirstOfEach {
    return this.replaceAll(RegExp(' +'), ' ').split(" ").map((str) => str.capitalize).join(" ");
  }
}
