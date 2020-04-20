import 'package:dartz/dartz.dart';
import 'package:redditapp/app/domain/repositories/reddit_repository.dart';
import 'package:redditapp/app/domain/repositories/storage_repository.dart';
import 'package:redditapp/core/errors/failures.dart';
import 'package:redditapp/core/use_cases/use_case.dart';

class RevokeRedditor implements UseCase<bool, NoParams> {
  final RedditRepository redditRepository;
  final StorageRepository storageRepository;

  RevokeRedditor(
    this.redditRepository,
    this.storageRepository,
  );

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    final response = await redditRepository.revokeRedditor();
    return response.fold(
      (failure) => Left(GeneralFailure()),
      (revokedUser) {
        if (revokedUser) {
          storageRepository.saveCredentials("");
          return Right(true);
        } else {
          return Right(false);
        }
      },
    );
  }
}
