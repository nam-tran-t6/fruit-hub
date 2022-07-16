extension StringX on String {
  int toHexColor() {
    try {
      return int.parse(this.substring(1, 7), radix: 16) + 0xFF000000;
    } catch (e) {
      return 0xFFFFFFFF;
    }
  }

  String capitalizeFirstLetter() {
    if (this.length > 0) {
      return this[0].toUpperCase() + this.substring(1).toLowerCase();
    }
    return this;
  }

  bool isNotBlank() {
    return this != '';
  }
}
