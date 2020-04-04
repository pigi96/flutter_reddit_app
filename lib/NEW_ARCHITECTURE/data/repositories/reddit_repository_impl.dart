import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/NEW_ARCHITECTURE/data/datasources/reddit_data_source.dart';
import 'package:redditapp/NEW_ARCHITECTURE/data/models/reddit.dart';

import 'package:redditapp/NEW_ARCHITECTURE/domain/repositories/reddit_repository.dart';
import 'package:redditapp/NEW_ARCHITECTURE/domain/repositories/storage_repository.dart';


class RedditRepositoryImpl extends RedditRepository {
  final RedditDataSource redditDataSource;

  RedditRepositoryImpl({
    @required this.redditDataSource,
  });

  @override
  Future<bool> authenticateUser({
    @required String code,
  }) {
    return redditDataSource.authenticateUser(
      code: code,
    );
  }

  @override
  Future<bool> restoreRedditAuthentication() {
    return redditDataSource.restoreRedditAuthentication();
  }

  @override
  String authenticationUrl() => redditDataSource.authenticationUrl().toString();

  @override
  Future<List<Subreddit>> subreddits({
    @required BrowseOption option,
  }) {
    return redditDataSource.subreddits(
      option: option,
    );
  }

  @override
  Future<List<Submission>> subredditsSubmissions({
    @required String title,
    @required SubmissionOption option,
    @required String after,
  }) {
    return redditDataSource.subredditsSubmissions(
      subredditTitle: title,
      option: option,
      after: after,
    );
  }

  @override
  Future<List<Subreddit>> usersSubscriptions({
    @required SubscriptionOption option,
  }) {
    return redditDataSource.usersSubscriptions(
      option: option,
    );
  }

  @override
  Future<Submission> submissions({
    @required String id,
  }) {
    return redditDataSource.submissions(
      id: id,
    );
  }

  @override
  Future<Redditor> redditor() {
    // TODO: implement redditor
    return null;
  }
}
