import 'package:dartz/dartz.dart';
import 'package:redditapp/core/errors/failures.dart';

abstract class StorageRepository {
  Future<Either<Failure, void>> saveCredentials(String credentials) {}

  Future<Either<Failure, String>> loadCredentials() {}
}