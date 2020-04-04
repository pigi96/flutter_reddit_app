import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/NEW_ARCHITECTURE/domain/repositories/reddit_repository.dart';
import 'package:redditapp/core/errors/failures.dart';
import 'package:redditapp/core/use_cases/use_case.dart';

class RedditAuthenticateUser implements UseCase<bool, Params> {
  final RedditRepository redditRepository;

  RedditAuthenticateUser(this.redditRepository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return Right(await redditRepository.authenticateUser(
      code: params.code,
    ));
  }
}

class Params extends Equatable {
  final String code;

  Params({@required this.code});

  @override
  List<Object> get props => [];
}