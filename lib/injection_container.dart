import 'package:get_it/get_it.dart';
import 'package:redditapp/app/data/repositories/reddit_repository_impl.dart';
import 'package:redditapp/app/data/repositories/storage_repository_impl.dart';
import 'package:redditapp/app/domain/use_cases/reddit/get_reddit_expand_comments.dart';
import 'package:redditapp/app/domain/use_cases/reddit/get_reddit_submission.dart';
import 'package:redditapp/app/domain/use_cases/reddit/get_reddit_subreddits.dart';
import 'package:redditapp/app/domain/use_cases/reddit/get_reddit_subreddits_submissions.dart';
import 'package:redditapp/app/domain/use_cases/reddit/get_reddit_submission_comments.dart';
import 'package:redditapp/app/domain/use_cases/reddit/get_reddit_subscriptions.dart';
import 'package:redditapp/app/domain/use_cases/reddit/post_reddit_comment_vote.dart';
import 'package:redditapp/app/domain/use_cases/reddit/post_reddit_submission_vote.dart';
import 'package:redditapp/app/domain/use_cases/reddit/post_reddit_subscribe.dart';
import 'package:redditapp/app/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:redditapp/app/presentation/bloc/browse/bloc_browse.dart';
import 'package:redditapp/app/presentation/bloc/comments/bloc_comments.dart';
import 'package:redditapp/app/presentation/bloc/navigation/bloc_navigation.dart';
import 'package:redditapp/app/presentation/bloc/subscriptions/bloc_subscriptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/data/datasources/reddit_data_source.dart';
import 'app/data/datasources/storage_data_source.dart';
import 'app/domain/repositories/reddit_repository.dart';
import 'app/domain/repositories/storage_repository.dart';
import 'app/domain/use_cases/reddit/reddit_authenticate_user.dart';
import 'app/domain/use_cases/reddit/reddit_authentication_url.dart';
import 'app/domain/use_cases/reddit/reddit_restore_authentication.dart';
import 'app/presentation/bloc/comments_info/comments_info_bloc.dart';
import 'app/presentation/bloc/submissions/submissions_bloc.dart';
import 'app/presentation/bloc/submissions_info/submissions_info_bloc.dart';

import 'package:draw/draw.dart';

import 'app/presentation/bloc/subscriptions_info/subscriptions_info_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc authentication
  sl.registerFactory(
    () => AuthenticationBloc(
      redditRestoreAuthentication: sl(),
      redditAuthenticateUser: sl(),
      redditAuthenticationUrl: sl(),
    ),
  );

  // Bloc navigation
  sl.registerFactory(() => NavigationBloc());

  // Bloc browse
  sl.registerFactory(() => BrowseBloc(getRedditSubreddits: sl()));

  // Bloc submissions
  sl.registerFactory(
      () => SubmissionsBloc(getRedditSubredditsSubmissions: sl()));

  // Bloc submissions info
  sl.registerFactoryParam<SubmissionsInfoBloc, Submission, void>((s, v) =>
      SubmissionsInfoBloc(
          redditRepository: sl(),
          postRedditSubmissionVote: sl(),
          submission: s));

  // Bloc comments
  sl.registerFactory(() => CommentsBloc(sl()));

  // Bloc comments info
  sl.registerFactoryParam<CommentsInfoBloc, Comment, MoreComments>(
      (c, m) => CommentsInfoBloc(
            redditRepository: sl(),
            postRedditCommentVote: sl(),
            getRedditExpandComments: sl(),
            comment: c,
            moreComments: m,
          ));

  // Bloc subscriptions
  sl.registerFactory(() => SubscriptionsBloc(
    redditRepository: sl(),
    getRedditSubscriptions: sl(),
  ));

  // Bloc subscriptions info
  sl.registerFactoryParam<SubscriptionsInfoBloc, Subreddit, void>((s, v) =>
      SubscriptionsInfoBloc(
        redditRepository: sl(),
        postRedditSubscribe: sl(),
        subreddit: s,
      ));

  // Use cases
  sl.registerLazySingleton(() => RedditAuthenticateUser(sl(), sl()));
  sl.registerLazySingleton(() => RedditAuthenticationUrl(sl()));
  sl.registerLazySingleton(() => RedditRestoreAuthentication(sl(), sl()));
  sl.registerLazySingleton(() => GetRedditSubredditsSubmissions(sl()));
  sl.registerLazySingleton(() => GetRedditSubreddits(sl()));
  sl.registerLazySingleton(() => GetRedditSubmission(sl()));
  sl.registerLazySingleton(() => GetRedditSubmissionComments(sl()));
  sl.registerLazySingleton(() => PostRedditCommentVote(sl()));
  sl.registerLazySingleton(() => PostRedditSubmissionVote(sl()));
  sl.registerLazySingleton(() => GetRedditExpandComments(sl()));
  sl.registerLazySingleton(() => GetRedditSubscriptions(sl()));
  sl.registerLazySingleton(() => PostRedditSubscribe(sl()));

  // Repository
  sl.registerLazySingleton<RedditRepository>(
    () => RedditRepositoryImpl(
      redditDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<StorageRepository>(
    () => StorageRepositoryImpl(
      storageDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<RedditDataSource>(() => RedditDataSource());
  sl.registerLazySingleton<StorageDataSource>(
    () => StorageDataSource(
      sharedPreferences: sl(),
    ),
  );

  //! Core

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
