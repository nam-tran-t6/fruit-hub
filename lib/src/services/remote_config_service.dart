import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_fruit_hub/src/constants/app_firebase_config_key.dart';
import 'package:flutter_fruit_hub/src/constants/strings.dart';

class AppRemoteConfigService {
  late RemoteConfig _remoteConfig;
  static final AppRemoteConfigService _singleton =
      AppRemoteConfigService._internal(RemoteConfig.instance);

  AppRemoteConfigService._internal(RemoteConfig config) {
    _remoteConfig = config;
  }

  factory AppRemoteConfigService() {
    return _singleton;
  }

  final defaults = <String, dynamic>{
    AppFirebaseConfigKey.HOME_WELCOME_MESSAGE: Strings.what_fruit_salad_you_want,
    AppFirebaseConfigKey.HOME_TOP_COLLECTION_TITLE: Strings.recommended_combo,
  };

  String get splashImage => _remoteConfig.getString(AppFirebaseConfigKey.SPLASH_IMAGE);

  String get homeWelcomeMessage =>
      _remoteConfig.getString(AppFirebaseConfigKey.HOME_WELCOME_MESSAGE);

  String get homeTopCollectionTitle =>
      _remoteConfig.getString(AppFirebaseConfigKey.HOME_TOP_COLLECTION_TITLE);

  String get authFruitBasketImageUrl =>
      _remoteConfig.getString(AppFirebaseConfigKey.AUTHENTICATION_FRUIT_BASKET);

  String get authFruitDropImageUrl =>
      _remoteConfig.getString(AppFirebaseConfigKey.AUTHENTICATION_FRUIT_DROP);

  String get welcomeFruitShadowImageUrl =>
      _remoteConfig.getString(AppFirebaseConfigKey.WELCOME_FRUIT_SHADOW);

  String get welcomeFruitImageUrl =>
      _remoteConfig.getString(AppFirebaseConfigKey.WELCOME_FRUIT_BASKET_IMAGE);

  String get welcomeFruitDropImageUrl =>
      _remoteConfig.getString(AppFirebaseConfigKey.WELCOME_FRUIT_DROP);

  String get welcomeFreshestCombo =>
      _remoteConfig.getString(AppFirebaseConfigKey.WELCOME_GET_FRESHEST_COMBO);

  String get welcomeBestCombo =>
      _remoteConfig.getString(AppFirebaseConfigKey.WELCOME_DELIVER_BEST_COMBO);

  String get welcomeMessageButton =>
      _remoteConfig.getString(AppFirebaseConfigKey.WELCOME_LETS_CONTINUE);

  Future setup() async {
    try {
      await _remoteConfig.setDefaults(defaults);
      var settings = RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: Duration(seconds: 1),
      );
      await _remoteConfig.setConfigSettings(settings);
      await fetchAndActive();
    } on Exception catch (e) {
      print(e);
    }
  }

  Future fetchAndActive() async {
    await _remoteConfig.fetchAndActivate();
  }
}
