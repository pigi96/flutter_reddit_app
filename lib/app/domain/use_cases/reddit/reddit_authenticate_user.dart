import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/app/domain/repositories/reddit_repository.dart';
import 'package:redditapp/app/domain/repositories/storage_repository.dart';
import 'package:redditapp/core/errors/failures.dart';
import 'package:redditapp/core/use_cases/use_case.dart';

class RedditAuthenticateUser implements UseCase<bool, Params> {
  final RedditRepository redditRepository;
  final StorageRepository storageRepository;

  RedditAuthenticateUser(this.redditRepository, this.storageRepository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    final authenticateUser = await redditRepository.authenticateUser(code: params.code);
    authenticateUser.fold(
        (failure) => false,
        (status) {
          final saveCredentials = storageRepository.saveCredentials(status);
          return true;
        },
    );

  }
}

class Params extends Equatable {
  final String code;

  Params({@required this.code});

  @override
  List<Object> get props => [];
}