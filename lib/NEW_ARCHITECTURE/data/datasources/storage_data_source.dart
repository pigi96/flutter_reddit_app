import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CREDENTIALS_LOCATION = "credentials_exported_loc";

class StorageDataSource {
  final SharedPreferences sharedPreferences;

  StorageDataSource({
    @required this.sharedPreferences,
  });

  void saveCredentials(String credentials) async {
    await sharedPreferences.setString(CREDENTIALS_LOCATION, credentials);
  }

  Future<String> loadCredentials() async {
    return sharedPreferences.getString(CREDENTIALS_LOCATION) ?? null;
  }
}