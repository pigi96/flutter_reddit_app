abstract class StorageRepository {
  Future<void> saveCredentials(String credentials) {}

  Future<String> loadCredentials() {}
}