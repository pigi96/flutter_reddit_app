import 'package:dartz/dartz.dart';
import 'package:draw/draw.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/app/data/models/reddit.dart';
import 'package:redditapp/app/domain/repositories/reddit_repository.dart';
import 'package:redditapp/core/errors/failures.dart';
import 'package:redditapp/core/use_cases/use_case.dart';

class PostRedditSubscribe implements UseCase<bool, Params> {
  final RedditRepository redditRepository;

  PostRedditSubscribe(this.redditRepository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return redditRepository.subSubreddit(subreddit: params.subreddit, option: params.option);
  }
}

class Params extends Equatable {
  final Subreddit subreddit;
  final SubscribeOption option;

  Params({@required this.option,
    @required this.subreddit});

  @override
  List<Object> get props => [];
}