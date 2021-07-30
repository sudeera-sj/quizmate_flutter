extension StringExtension on String {
  /// Returns a String with the very first character capitalized
  String get capitalize {
    return this.length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
  }

  /// Returns a String with the first character of each word capitalized
  String get capitalizeFirstOfEach {
    return this.replaceAll(RegExp(' +'), ' ').split(" ").map((str) => str.capitalize).join(" ");
  }
}
