
import 'package:shared_preferences/shared_preferences.dart';

class ColorsSharedPref {
  static SharedPreferences? _prefs;
  static const String _color = 'purple';

  /// Initializes the SharedPreferences instance for local data storage.
  static Future init() async => _prefs = await SharedPreferences.getInstance();

  // Setters

  /// Sets the IP address for the lg session.
  static Future<void> setAPIKey(String apiKey) async =>
      await _prefs?.setString(_color, apiKey);

  // Getters

  /// Retrieves the saved IP address from the lg session.
  static String? getAPIKey() => _prefs?.getString(_color);

  // Removers

  /// Removes the saved IP address from the lg session.
  static Future<void> removeAPIKey() async => await _prefs?.remove(_color);
}
