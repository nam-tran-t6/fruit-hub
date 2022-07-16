import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils{

  late SharedPreferences _sharedPreferences;

  static final SharedPreferencesUtils _singleton = SharedPreferencesUtils._internal();

  SharedPreferencesUtils._internal();

  factory SharedPreferencesUtils()=>_singleton;

  Future<SharedPreferences> setup() async{
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences;
  }

  //Get
  bool? getBool(String key) => _sharedPreferences.getBool(key);

  String? getString(String key) => _sharedPreferences.getString(key);

// Set
  Future<bool> setBool(String key, bool value) => _sharedPreferences.setBool(key, value);

  Future<bool> setString(String key, String value)  =>  _sharedPreferences.setString(key, value);

}