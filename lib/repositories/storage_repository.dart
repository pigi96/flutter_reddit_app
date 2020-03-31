import 'package:redditapp/repositories/repositories/storage_repository_sup.dart';
import 'package:redditapp/storage/storage.dart';

class StorageRepository extends StorageRepositorySup {
  @override
  Future<void> saveCredentials(String credentials) async {
    Storage.instance.saveCredentials(credentials);
  }

  @override
  Future<String> loadCredentials() async {
    return Storage.instance.loadCredentials();
  }
}