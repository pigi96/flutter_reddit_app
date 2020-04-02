import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import "package:redditapp/config.dart";
import 'package:redditapp/reddit/reddit.dart';
import 'package:redditapp/repositories/storage_repository.dart';


/// The [RedditAPI] class uses a singleton pattern to get initialized and
/// provides access to a few methods available in [Reddit] class.
class RedditAPI {
  // Only a single instance will exist since the above class is a singleton.
  Reddit _reddit;

  // Create and call constructor for the single instance that is shared across
  // application.
  RedditAPI._privateConstructor();
  static final RedditAPI instance = RedditAPI._privateConstructor();

  /// Method has to be called before [RedditAPI] is allowed to be used.
  ///
  /// Initialize a [Reddit] instance according to locally saved stuff in
  /// [storageRepository], if the credentials contain data, restore the
  /// previous installed flow instance, otherwise create a new installed
  /// flow instance.
  ///
  /// Return true if [_reddit] is restored.
  Future<bool> restoreRedditAuthentication({
    @required StorageRepository storageRepository,
  }) async {
    // Load cached credentials from disk, if available.
    String credentials = await storageRepository.loadCredentials();

    // Check if loaded credentials exist.
    if (credentials != null && credentials.isNotEmpty) {
      // App has saved authentication data, restore instance

      _reddit = Reddit.restoreInstalledAuthenticatedInstance(credentials,
          userAgent: Config.identifier,
          clientId: Config.clientId,
          redirectUri: Uri.parse(Config.redirectUri));

      return true;
    }

    // App has no data, create a new instance
    _reddit = Reddit.createInstalledFlowInstance(
        userAgent: Config.identifier,
        clientId: Config.clientId,
        redirectUri: Uri.parse(Config.redirectUri));
    return false;
  }

  /// Return true if user with secret [code] was successfully authenticated.
  Future<bool> authenticateUser({
    @required StorageRepository storageRepository,
    @required String code,
  }) async {
    try {
      await _reddit.auth.authorize(code);

    } catch (error) {
      return false;
    }

    // Write credentials to disk.
    await storageRepository.saveCredentials(_reddit.auth.credentials.toJson());

    return true;
  }

  /// Return [Uri] using already instantiated [reddit].
  Uri authenticationUrl() {
    Uri url = _reddit.auth.url([
      "identity",
      "read",
    ], Config.identifier);
    return url;
  }

  Future<Redditor> redditor() async {
    return _reddit.user.me();
  }

  /// Returns a [List] of [Subreddit].
  ///
  /// Create a [Stream] that listens to data according to given [option].
  Future<List<Subreddit>> subreddits({
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
    print("PATH: ${subreddits[1].displayName}");

    return subreddits;
  }

  /// Returns a [List] of [Submission].
  ///
  /// Create a [Stream] that listens to data according to given [option] and
  /// search for [subredditTitle] as it's reddit subreddit topic.
  Future<List<Submission>> subredditsSubmissions({
    @required String subredditTitle,
    @required SubmissionOption option,
    @required var group,
  }) async {
    print(subredditTitle);
    Stream stream;
    switch (option) {
      case SubmissionOption.newest:
        stream = _reddit.subreddit(subredditTitle).newest(limit: 30);
        break;
      case SubmissionOption.hot:
        stream = _reddit.subreddit(subredditTitle).hot(
          limit: 30,
        );
        break;
      case SubmissionOption.controversial:
        stream = _reddit.subreddit(subredditTitle).controversial(
          limit: 30,
        );
        break;
      case SubmissionOption.top:
        stream = _reddit.subreddit(subredditTitle).top(
          limit: 30,
        );
        break;
    }

    List<Submission> submissions = List<Submission>();
    await for (final value in stream) {
      submissions.add(value);
    }
    print(submissions[1]);

    return submissions;
  }

  /// Returns a [List] of [Subreddit] user is subscribed to.
  ///
  /// Create a [Stream] that listens to data according to given [option] and
  /// search for currently authorized user's [List] of subscribed [Subreddit].
  Future<List<Subreddit>> usersSubscriptions({
    @required SubscriptionOption option,
  }) async {
    Stream stream;
    switch (option) {
      case SubscriptionOption.defaults:
        stream = _reddit.user.subreddits();
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

    return subreddits;
  }
}