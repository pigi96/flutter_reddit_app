import 'package:dartz/dartz.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/NEW_ARCHITECTURE/data/models/reddit.dart';
import 'package:redditapp/core/errors/failures.dart';

abstract class RedditRepository {
  Future<Either<Failure, String>> authenticateUser({
    @required String code,
  });

  Future<Either<Failure, bool>> restoreRedditAuthentication({
    @required String credentials,
  });

  Future<Either<Failure, String>> authenticationUrl();

  Future<Either<Failure, List<Subreddit>>> subreddits({
    @required BrowseOption option,
  });

  Future<Either<Failure, List<Submission>>> subredditsSubmissions({
    @required String title,
    @required SubmissionOption option,
    @required String after,
  });

  Future<Either<Failure, List<Subreddit>>> usersSubscriptions({
    @required SubscriptionOption option,
  });

  Future<Either<Failure, Submission>> submission({
    @required String id,
  });

  Future<Either<Failure, Submission>> comments({
    @required Submission submission,
  });
}