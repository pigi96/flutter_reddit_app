import 'package:flutter/cupertino.dart';
import 'package:redditapp/NEW_ARCHITECTURE/data/datasources/storage_data_source.dart';
import 'package:redditapp/NEW_ARCHITECTURE/domain/repositories/storage_repository.dart';

class StorageRepositoryImpl extends StorageRepository {
  final StorageDataSource storageDataSource;

  StorageRepositoryImpl({
    @required this.storageDataSource,
  });

  @override
  Future<void> saveCredentials(String credentials) async {
    storageDataSource.saveCredentials(credentials);
  }

  @override
  Future<String> loadCredentials() async {
    return storageDataSource.loadCredentials();
  }
}