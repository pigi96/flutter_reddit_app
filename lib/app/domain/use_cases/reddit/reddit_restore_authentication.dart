import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:redditapp/app/domain/repositories/reddit_repository.dart';
import 'package:redditapp/app/domain/repositories/storage_repository.dart';
import 'package:redditapp/core/errors/failures.dart';
import 'package:redditapp/core/use_cases/use_case.dart';

class RedditRestoreAuthentication implements UseCase<bool, NoParams> {
  final RedditRepository redditRepository;
  final StorageRepository storageRepository;

  RedditRestoreAuthentication(this.redditRepository, this.storageRepository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    final getCredentials = await storageRepository.loadCredentials();
    String credentials = getCredentials.fold(
        (failure) => null,
        (status) => status,
    );
    return redditRepository.restoreRedditAuthentication(credentials: credentials);
  }
}

class Params extends Equatable {
  @override
  List<Object> get props => [];
}