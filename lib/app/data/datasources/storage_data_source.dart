import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/core/errors/failures.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CREDENTIALS_LOCATION = "credentials";

class StorageDataSource {
  final SharedPreferences sharedPreferences;

  StorageDataSource({
    @required this.sharedPreferences,
  });

  Future<Either<Failure, void>> saveCredentials(String credentials) async {
    await sharedPreferences.setString(CREDENTIALS_LOCATION, credentials);

    return Right((){});
  }

  Future<Either<Failure, String>> loadCredentials() async {
    return Right(sharedPreferences.getString(CREDENTIALS_LOCATION) ?? null);
  }
}