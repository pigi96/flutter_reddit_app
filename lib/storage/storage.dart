import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Storage._privateConstructor();
  static final Storage instance = Storage._privateConstructor();

  SharedPreferences prefs;

  void saveCredentials(String credentials) async {
    await prefs.setString('credentials', credentials);
  }

  Future<String> loadCredentials() async {
    return prefs.getString('credentials') ?? null;
  }
}