import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:redditapp/NEW_ARCHITECTURE/domain/repositories/reddit_repository.dart';
import 'package:redditapp/core/errors/failures.dart';
import 'package:redditapp/core/use_cases/use_case.dart';

class RedditAuthenticationUrl implements UseCase<String, NoParams> {
  final RedditRepository redditRepository;

  RedditAuthenticationUrl(this.redditRepository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return Right(redditRepository.authenticationUrl());
  }
}

class Params extends Equatable {
  @override
  List<Object> get props => [];
}