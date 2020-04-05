import 'package:dartz/dartz.dart';
import 'package:draw/draw.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/NEW_ARCHITECTURE/data/models/reddit.dart';
import 'package:redditapp/NEW_ARCHITECTURE/domain/repositories/reddit_repository.dart';
import 'package:redditapp/core/errors/failures.dart';
import 'package:redditapp/core/use_cases/use_case.dart';

class GetRedditSubreddits implements UseCase<List<Subreddit>, Params> {
  final RedditRepository redditRepository;

  GetRedditSubreddits(this.redditRepository);

  @override
  Future<Either<Failure, List<Subreddit>>> call(Params params) async {
    return redditRepository.subreddits(option: params.option);
  }
}

class Params extends Equatable {
  final BrowseOption option;

  Params({@required this.option});

  @override
  List<Object> get props => [];
}