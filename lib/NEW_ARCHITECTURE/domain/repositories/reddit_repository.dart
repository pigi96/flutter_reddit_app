import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/NEW_ARCHITECTURE/data/models/reddit.dart';
import 'package:redditapp/NEW_ARCHITECTURE/domain/repositories/storage_repository.dart';

abstract class RedditRepository {
  Future<bool> authenticateUser({
    @required String code,
  });

  Future<bool> restoreRedditAuthentication();

  Future<Redditor> redditor();

  String authenticationUrl();

  Future<List<Subreddit>> subreddits({
    @required BrowseOption option,
  });

  Future<List<Submission>> subredditsSubmissions({
    @required String title,
    @required SubmissionOption option,
    @required String after,
  });

  Future<List<Subreddit>> usersSubscriptions({
    @required SubscriptionOption option,
  });

  Future<Submission> submissions({
    @required String id,
  });
}