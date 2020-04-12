import 'package:dartz/dartz.dart';
import 'package:draw/draw.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/app/data/models/reddit.dart';
import 'package:redditapp/app/domain/repositories/reddit_repository.dart';
import 'package:redditapp/core/errors/failures.dart';
import 'package:redditapp/core/use_cases/use_case.dart';

import 'get_reddit_expand_comments.dart';

class GetRedditSubscriptions implements UseCase<List<Subreddit>, Params> {
  final RedditRepository redditRepository;

  GetRedditSubscriptions(this.redditRepository);

  @override
  Future<Either<Failure, List<Subreddit>>> call(Params params) {
    return redditRepository.usersSubscriptions(option: params.option);
  }
}

class Params extends Equatable {
  SubscriptionOption option;

  Params({@required this.option});

  @override
  List<Object> get props {

  }
}