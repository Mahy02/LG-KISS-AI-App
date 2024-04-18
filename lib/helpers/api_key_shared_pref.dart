import 'package:shared_preferences/shared_preferences.dart';

class ApiKeySharedPref {
  static SharedPreferences? _prefs;
  static const String _apiKey = '';

  /// Initializes the SharedPreferences instance for local data storage.
  static Future init() async => _prefs = await SharedPreferences.getInstance();

  // Setters

  /// Sets the IP address for the aoiKey session.
  static Future<void> setAPIKey(String apiKey) async =>
      await _prefs?.setString(_apiKey, apiKey);



  // Getters

  /// Retrieves the saved IP address from the apiKey session.
  static String? getAPIKey() => _prefs?.getString(_apiKey);


  // Removers

  /// Removes the saved IP address from the apiKey session.
  static Future<void> removeAPIKey() async => await _prefs?.remove(_apiKey);




}