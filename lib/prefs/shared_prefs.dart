import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getPrefs() async => SharedPreferences.getInstance();

// Future<void> saveToken({
//   @required String value,
// }) async {
//   final prefs = await getPrefs();
//   prefs.setString(kSharedToken, value);
// }

// Future<String> getToken() async {
//   final prefs = await getPrefs();
//   return prefs.getString(kSharedToken);
// }

Future<void> clearPrefs() async {
  final prefs = await getPrefs();
  return prefs.clear();
}
