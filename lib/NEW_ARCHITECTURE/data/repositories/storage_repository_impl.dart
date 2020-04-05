import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/NEW_ARCHITECTURE/data/datasources/storage_data_source.dart';
import 'package:redditapp/NEW_ARCHITECTURE/domain/repositories/storage_repository.dart';
import 'package:redditapp/core/errors/failures.dart';

class StorageRepositoryImpl implements StorageRepository {
  final StorageDataSource storageDataSource;

  StorageRepositoryImpl({
    @required this.storageDataSource,
  });

  @override
  Future<Either<Failure, String>> loadCredentials() {
    return storageDataSource.loadCredentials();
  }

  @override
  Future<Either<Failure, void>> saveCredentials(String credentials) {
    return storageDataSource.saveCredentials(credentials);
  }


}