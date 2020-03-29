import 'package:redditapp/storage/storage.dart';

class StorageRepository {
  Future<void> saveCredentials(String credentials) async {
    Storage.instance.saveCredentials(credentials);
  }

  Future<String> loadCredentials() async {
    return Storage.instance.loadCredentials();
  }
}