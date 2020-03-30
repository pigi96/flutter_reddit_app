import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import "package:redditapp/config.dart";
import 'package:redditapp/helpers/credentials.dart';
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
    if (credentials.isNotEmpty) {
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

  Stream subreddit() {
    return _reddit.subreddits.newest(limit: 100);
  }
}