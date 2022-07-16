class AppRatio {
  static const int _HEIGHT_DESIGN = 812;

  static const int _WIDTH_DESIGN = 375;

  late double _height;

  late double _width;

  static final AppRatio _singleton = AppRatio._internal();

  factory AppRatio() {
    return _singleton;
  }

  void setScreenSize(double width, double height) {
    this._width = width;
    this._height = height;
  }

  AppRatio._internal();

  double getHeightByRadio(double size) {
    var heightByRatio = _height * (size / _HEIGHT_DESIGN);
    return heightByRatio;
  }

  double getWidthByRadio(double size) {
    var widthByRatio = _width * (size / _WIDTH_DESIGN);
    return widthByRatio;
  }
}
