import 'package:dartz/dartz.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/app/data/models/reddit.dart';
import "package:redditapp/config.dart";
import 'package:redditapp/core/errors/failures.dart';

/// The [RedditDataSource] class uses a singleton pattern to get initialized and
/// provides access to a few methods available in [Reddit] class.
class RedditDataSource {
  // Only a single instance will exist since the above class is a singleton.
  Reddit _reddit;

  // Create and call constructor for the single instance that is shared across
  // application.

  /// Method has to be called before [RedditDataSource] is allowed to be used.
  ///
  /// Initialize a [Reddit] instance according to locally saved stuff in
  /// [storageRepository], if the credentials contain data, restore the
  /// previous installed flow instance, otherwise create a new installed
  /// flow instance.
  ///
  /// Return true if [_reddit] is restored.
  Future<Either<Failure, bool>> restoreRedditAuthentication({
    @required String credentials,
  }) async {
    // Check if loaded credentials exist.
    if (credentials != null && credentials.isNotEmpty) {
      // App has saved authentication data, restore instance
      try {
        _reddit = Reddit.restoreInstalledAuthenticatedInstance(credentials,
            userAgent: Config.identifier,
            clientId: Config.clientId,
            redirectUri: Uri.parse(Config.redirectUri));

        await _reddit.user.friends().catchError((onError) {
          _reddit = Reddit.createInstalledFlowInstance(
              userAgent: Config.identifier,
              clientId: Config.clientId,
              redirectUri: Uri.parse(Config.redirectUri));
          return Left(Authorization());
        });
      } catch (error) {
        // App has data, but user has denied access in reddit settings or
        // no internet network available
        _reddit = Reddit.createInstalledFlowInstance(
            userAgent: Config.identifier,
            clientId: Config.clientId,
            redirectUri: Uri.parse(Config.redirectUri));
        return Left(Authorization());
      }

      return Right(true);
    }

    // App has no data, create a new instance
    _reddit = Reddit.createInstalledFlowInstance(
        userAgent: Config.identifier,
        clientId: Config.clientId,
        redirectUri: Uri.parse(Config.redirectUri));
    return Right(false);
  }

  /// Return true if user with secret [code] was successfully authenticated.
  Future<Either<Failure, String>> authenticateUser({
    @required String code,
  }) async {
    try {
      await _reddit.auth.authorize(code);
    } catch (error) {
      return Left(Authorization());
    }

    return Right(_reddit.auth.credentials.toJson());
  }

  /// Return [Uri] using already instantiated [reddit].
  Future<Either<Failure, String>> authenticationUrl() async {
    Uri url = _reddit.auth.url([
      "identity",
      "read",
      "vote",
      "subscribe",
      "mysubreddits",
    ], Config.identifier);

    return Right(url.toString());
  }

  Future<Redditor> redditor() async {
    return _reddit.user.me();
  }

  /// Returns a [List] of [Subreddit].
  ///
  /// Create a [Stream] that listens to data according to given [option].
  Future<Either<Failure, List<Subreddit>>> subreddits({
    @required BrowseOption option,
  }) async {
    Stream stream;
    switch(option) {
      case BrowseOption.newest:
        stream = _reddit.subreddits.newest(limit: 99);
        break;
      case BrowseOption.popular:
        stream = _reddit.subreddits.popular(limit: 99);
        break;
      case BrowseOption.gold:
        stream = _reddit.subreddits.gold(limit: 99);
        break;
      default:
        stream = _reddit.subreddits.defaults(limit: 99);
        break;
    }

    List<Subreddit> subreddits = List<Subreddit>();
    await for (final value in stream) {
      subreddits.add(value);
    }

    return Right(subreddits);
  }

  /// Returns a [List] of [Submission].
  ///
  /// Create a [Stream] that listens to data according to given [option] and
  /// search for [subredditTitle] as it's reddit subreddit topic.
  Future<Either<Failure, List<Submission>>> subredditsSubmissions({
    @required String subredditTitle,
    @required SubmissionOption option,
    @required String after,
  }) async {
    Stream stream;
    switch (option) {
      case SubmissionOption.newest:
        stream = _reddit.subreddit(subredditTitle).newest(limit: 10,
          after: after,
        );
        break;
      case SubmissionOption.hot:
        stream = _reddit.subreddit(subredditTitle).hot(
          limit: 10,
          after: after,
        );
        break;
      case SubmissionOption.controversial:
        stream = _reddit.subreddit(subredditTitle).controversial(
          limit: 10,
          after: after,
        );
        break;
      case SubmissionOption.top:
        stream = _reddit.subreddit(subredditTitle).top(
          limit: 10,
          after: after,
        );
        break;
    }

    List<Submission> submissions = List<Submission>();
    await for (final value in stream) {
      submissions.add(value);
    }

    return Right(submissions);
  }

  Future<Either<Failure, Submission>> submission({
    @required String id,
  }) async {
    SubmissionRef submissionRef = _reddit.submission(
      id: id,
    );

    Submission submission = await submissionRef.populate();

    return Right(submission);
  }

  /// Returns a [List] of [Subreddit] user is subscribed to.
  ///
  /// Create a [Stream] that listens to data according to given [option] and
  /// search for currently authorized user's [List] of subscribed [Subreddit].
  Future<Either<Failure, List<Subreddit>>> usersSubscriptions({
    @required SubscriptionOption option,
  }) async {
    Stream stream;
    switch (option) {
      case SubscriptionOption.defaults:
        stream = _reddit.user.subreddits(limit: 25);
        break;
      case SubscriptionOption.contributor:
        stream = _reddit.user.contributorSubreddits();
        break;
      case SubscriptionOption.moderator:
        stream = _reddit.user.moderatorSubreddits();
        break;
    }

    List<Subreddit> subreddits = List<Subreddit>();
    await for(final value in stream) {
      subreddits.add(value);
    }

    return Right(subreddits);
  }

  /// Returns a [List] of [Submission].
  ///
  /// Create a [Stream] that listens to data according to given [option] and
  /// search for [subredditTitle] as it's reddit subreddit topic.
  Future<Either<Failure, Submission>> comments({
    @required Submission submission,
  }) async {
    await submission.refreshComments();
    return Right(submission);
  }

  /// Upvote or downvote a [Submission]
  Future<Either<Failure, Submission>> submissionVote({
    @required Submission submission,
    @required VoteOption option,
  }) async {
    var response;
    switch (option) {
      case VoteOption.up:
        response = submission.upvote(waitForResponse: true);
        break;
      case VoteOption.down:
        response = submission.downvote(waitForResponse: true);
        break;
      case VoteOption.clear:
        response = submission.clearVote(waitForResponse: true);
        break;
    }

    await response;

    return Right(submission);
  }

  /// Upvote or downvote a [Comment]
  Future<Either<Failure, Comment>> commentVote({
    @required Comment comment,
    @required VoteOption option,
  }) async {
    var response;
    switch (option) {
      case VoteOption.up:
        response = comment.upvote(waitForResponse: true);
        break;
      case VoteOption.down:
        response = comment.downvote(waitForResponse: true);
        break;
      case VoteOption.clear:
        response = comment.clearVote(waitForResponse: true);
        break;
    }

    await response;

    return Right(comment);
  }

  /// Expand them comments
  Future<Either<Failure, dynamic>> expandComments({
    @required MoreComments moreComments,
  }) async {
    var response = await moreComments.submission.populate();
    return Right(response);
  }

  /// Sub/unsubscribe on subreddit
  Future<Either<Failure, Subreddit>> subSubreddit({
    @required Subreddit subreddit,
    @required SubscribeOption option,
  }) async {
    if (subreddit.data["user_is_subscriber"]) {
      await subreddit.unsubscribe();
      subreddit.data["user_is_subscriber"] = false;
    } else {
      await subreddit.subscribe();
      subreddit.data["user_is_subscriber"] = true;
    }

    return Right(subreddit);
  }
}