import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/reddit/reddit.dart';

import '../storage_repository.dart';

abstract class RedditRepositorySup {
  Future<bool> authenticateUser({
    @required StorageRepository storageRepository,
    @required String code,
  });

  Future<bool> restoreRedditAuthentication({
    @required StorageRepository storageRepository,
  });

  Future<Redditor> redditor();

  Uri authenticationUrl();

  Future<List<Subreddit>> subreddits({
    @required BrowseOption option,
  });

  Future<List<Submission>> subredditsSubmissions({
    @required String title,
    @required SubmissionOption option,
    @required var group,
  });

  Future<List<Subreddit>> usersSubscriptions({
    @required SubscriptionOption option,
  });
}