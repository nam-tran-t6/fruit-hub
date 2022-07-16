import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/constants/enum/app_overlay_loading_status.dart';
import 'package:flutter_fruit_hub/src/constants/strings.dart';

/// State of the [AppOverlayLoadingWidget].

class AppOverlayLoadingWidget {
  AppOverlayLoadingWidget._internal();

  static final AppOverlayLoadingWidget _instance = AppOverlayLoadingWidget._internal();

  factory AppOverlayLoadingWidget() => _instance;

  LoadingWidgetState _state = LoadingWidgetState.none;
  BuildContext? _overlayScreenContext;
  final Map<String, CustomOverlayScreen> _customOverLayScreens = {
    'default-loading': CustomOverlayScreen(
      backgroundColor: Colors.transparent,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(height: 20.0),
          Text(
            Strings.loading_message,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    )
  };

  LoadingWidgetState get state => _state;

  /// This method saves widgets to show by [show].
  void saveScreens(Map<String, CustomOverlayScreen> widgets) =>
      _instance._customOverLayScreens.addAll(widgets);

  /// This method removes widgets to show by [show].
  void removeScreens(List<String> identifiers) => identifiers
      .forEach((identifier) => _instance._customOverLayScreens.remove(identifier));

  /// This method displays a [AppOverlayLoadingWidget] by an identifier.
  void show(
    BuildContext context, {
    String identifier = 'default-loading',
  }) {
    assert(_instance._customOverLayScreens.isNotEmpty, "overlay screens empty");
    assert(_customOverLayScreens.containsKey(identifier), "widget not found");
    if (_instance._state == LoadingWidgetState.showing) {
      return;
    }

    _instance._state = LoadingWidgetState.showing;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        _instance._overlayScreenContext = context;
        return _customOverLayScreens[identifier]!;
      },
    );
  }

  bool isShowing() {
    return state == LoadingWidgetState.showing;
  }

  void pop() {
    if (!isShowing()) {
      return;
    }
    Navigator.pop(_instance._overlayScreenContext!);
    _instance._overlayScreenContext = null;
    _instance._state = LoadingWidgetState.none;
  }
}

class CustomOverlayScreen extends StatelessWidget {
  final Color backgroundColor;

  final Widget content;

  CustomOverlayScreen({
    required this.content,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: backgroundColor,
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      content: Container(
        height: size.height,
        width: size.width,
        child: content,
      ),
    );
  }
}
