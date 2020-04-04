import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:redditapp/NEW_ARCHITECTURE/domain/repositories/reddit_repository.dart';
import 'package:redditapp/core/errors/failures.dart';
import 'package:redditapp/core/use_cases/use_case.dart';

class RedditRestoreAuthentication implements UseCase<bool, NoParams> {
  final RedditRepository redditRepository;

  RedditRestoreAuthentication(this.redditRepository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return Right(await redditRepository.restoreRedditAuthentication());
  }
}

class Params extends Equatable {
  @override
  List<Object> get props => [];
}