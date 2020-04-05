import 'package:dartz/dartz.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/NEW_ARCHITECTURE/data/datasources/reddit_data_source.dart';
import 'package:redditapp/NEW_ARCHITECTURE/data/models/reddit.dart';
import 'package:redditapp/NEW_ARCHITECTURE/domain/repositories/reddit_repository.dart';
import 'package:redditapp/core/errors/failures.dart';


class RedditRepositoryImpl implements RedditRepository {
  final RedditDataSource redditDataSource;

  RedditRepositoryImpl({
    @required this.redditDataSource,
  });

  @override
  Future<Either<Failure, Submission>> submission({String id}) {
    return redditDataSource.submission(id: id);
  }

  @override
  Future<Either<Failure, String>> authenticateUser({String code}) {
    return redditDataSource.authenticateUser(code: code);
  }

  @override
  Future<Either<Failure, String>> authenticationUrl() async {
    return await redditDataSource.authenticationUrl();
  }

  @override
  Future<Either<Failure, bool>> restoreRedditAuthentication({String credentials}) {
    return redditDataSource.restoreRedditAuthentication(credentials: credentials);
  }

  @override
  Future<Either<Failure, List<Subreddit>>> subreddits({BrowseOption option}) {
    return redditDataSource.subreddits(option: option);
  }

  @override
  Future<Either<Failure, List<Submission>>> subredditsSubmissions({String title, SubmissionOption option, String after}) {
    return subredditsSubmissions(title: title, after: after);
  }

  @override
  Future<Either<Failure, List<Subreddit>>> usersSubscriptions({SubscriptionOption option}) {
    return usersSubscriptions(option: option);
  }
}
