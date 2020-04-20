import 'package:dartz/dartz.dart';
import 'package:draw/draw.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/app/data/models/reddit.dart';
import 'package:redditapp/app/domain/repositories/reddit_repository.dart';
import 'package:redditapp/core/errors/failures.dart';
import 'package:redditapp/core/use_cases/use_case.dart';

class GetRedditRedditor implements UseCase<Redditor, NoParams> {
  final RedditRepository redditRepository;

  GetRedditRedditor(this.redditRepository);

  @override
  Future<Either<Failure, Redditor>> call(NoParams params) async {
    return redditRepository.redditor();
  }
}