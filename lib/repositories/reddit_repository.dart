import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/reddit/reddit.dart';
import 'package:redditapp/reddit/reddit_api.dart';
import 'package:redditapp/repositories/repositories/reddit_repository_sup.dart';
import 'package:redditapp/repositories/storage_repository.dart';

class RedditRepository extends RedditRepositorySup {
  @override
  Future<bool> authenticateUser({
    @required StorageRepository storageRepository,
    @required String code,
  }) {
    return RedditAPI.instance.authenticateUser(
      storageRepository: storageRepository,
      code: code,
    );
  }

  @override
  Future<bool> restoreRedditAuthentication({
    @required StorageRepository storageRepository,
  }) {
    return RedditAPI.instance.restoreRedditAuthentication(
      storageRepository: storageRepository,
    );
  }

  @override
  Future<Redditor> redditor() => RedditAPI.instance.redditor();

  @override
  Uri authenticationUrl() => RedditAPI.instance.authenticationUrl();

  @override
  Future<List<Subreddit>> subreddits({
    @required BrowseOption option,
  }) {
    return RedditAPI.instance.subreddits(
      option: option,
    );
  }

  @override
  Future<List<Submission>> subredditsSubmissions({
    @required String title,
    @required SubmissionOption option,
    @required String after,
  }) {
    return RedditAPI.instance.subredditsSubmissions(
      subredditTitle: title,
      option: option,
      after: after,
    );
  }

  @override
  Future<List<Subreddit>> usersSubscriptions({
    @required SubscriptionOption option,
  }) {
    return RedditAPI.instance.usersSubscriptions(
      option: option,
    );
  }

  @override
  Future<Submission> submissions({
    @required String id,
  }) {
    return RedditAPI.instance.submissions(
      id: id,
    );
  }
}
