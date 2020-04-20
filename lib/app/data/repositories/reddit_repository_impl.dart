import 'package:dartz/dartz.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/app/data/datasources/reddit_data_source.dart';
import 'package:redditapp/app/data/models/reddit.dart';
import 'package:redditapp/app/domain/repositories/reddit_repository.dart';
import 'package:redditapp/core/errors/failures.dart';


class RedditRepositoryImpl implements RedditRepository {
  final RedditDataSource redditDataSource;

  RedditRepositoryImpl({
    @required this.redditDataSource,
  });

  @override
  Future<Either<Failure, bool>> revokeRedditor() {
    return redditDataSource.revokeRedditor();
  }

  @override
  Future<Either<Failure, Redditor>> redditor() {
    return redditDataSource.redditor();
  }

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
    return redditDataSource.subredditsSubmissions(subredditTitle: title, after: after, option: option);
  }

  @override
  Future<Either<Failure, List<Subreddit>>> usersSubscriptions({SubscriptionOption option}) {
    return redditDataSource.usersSubscriptions(option: option);
  }

  @override
  Future<Either<Failure, Submission>> comments({Submission submission})  {
    return redditDataSource.comments(submission: submission);
  }

  Future<Either<Failure, Submission>> submissionVote({
    Submission submission,
    VoteOption option,
  }) {
    return redditDataSource.submissionVote(submission: submission, option: option);
  }

  Future<Either<Failure, Comment>> commentVote({
    Comment comment,
    VoteOption option,
  }) {
    return redditDataSource.commentVote(comment: comment, option: option);
  }

  Future<Either<Failure, dynamic>> expandComments({
    @required MoreComments moreComments,
  }) {
    return redditDataSource.expandComments(moreComments: moreComments);
  }

  Future<Either<Failure, Subreddit>> subSubreddit({
    @required Subreddit subreddit,
    @required SubscribeOption option,
  }) {
    return redditDataSource.subSubreddit(subreddit: subreddit, option: option);
  }
}
