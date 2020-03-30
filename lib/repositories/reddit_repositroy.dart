import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/reddit/reddit_api.dart';
import 'package:redditapp/repositories/storage_repository.dart';

class RedditRepository {
  Future<bool> authenticateUser({
    @required StorageRepository storageRepository,
    @required String code,
  }) {
    return RedditAPI.instance.authenticateUser(
      storageRepository: storageRepository,
      code: code,
    );
  }

  Future<bool> restoreRedditAuthentication({
    @required StorageRepository storageRepository,
  }) {
    return RedditAPI.instance.restoreRedditAuthentication(
      storageRepository: storageRepository,
    );
  }

  Future<Redditor> redditor() =>
      RedditAPI.instance.redditor();

  Uri authenticationUrl() =>
      RedditAPI.instance.authenticationUrl();

  Stream subreddits() {
    return RedditAPI.instance.subreddit();
  }
}