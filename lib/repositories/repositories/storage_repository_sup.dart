import 'package:redditapp/storage/storage.dart';

abstract class StorageRepositorySup {
  Future<void> saveCredentials(String credentials) {}

  Future<String> loadCredentials() {}
}