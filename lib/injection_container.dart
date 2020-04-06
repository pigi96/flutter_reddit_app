import 'package:get_it/get_it.dart';
import 'package:redditapp/NEW_ARCHITECTURE/data/repositories/reddit_repository_impl.dart';
import 'package:redditapp/NEW_ARCHITECTURE/data/repositories/storage_repository_impl.dart';
import 'package:redditapp/NEW_ARCHITECTURE/domain/use_cases/reddit/get_reddit_submission.dart';
import 'package:redditapp/NEW_ARCHITECTURE/domain/use_cases/reddit/get_reddit_subreddits.dart';
import 'package:redditapp/NEW_ARCHITECTURE/domain/use_cases/reddit/get_reddit_subreddits_submissions.dart';
import 'package:redditapp/NEW_ARCHITECTURE/domain/use_cases/reddit/get_reddit_submission_comments.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/browse/bloc_browse.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/comments/bloc_comments.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/navigation/bloc_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'NEW_ARCHITECTURE/data/datasources/reddit_data_source.dart';
import 'NEW_ARCHITECTURE/data/datasources/storage_data_source.dart';
import 'NEW_ARCHITECTURE/domain/repositories/reddit_repository.dart';
import 'NEW_ARCHITECTURE/domain/repositories/storage_repository.dart';
import 'NEW_ARCHITECTURE/domain/use_cases/reddit/reddit_authenticate_user.dart';
import 'NEW_ARCHITECTURE/domain/use_cases/reddit/reddit_authentication_url.dart';
import 'NEW_ARCHITECTURE/domain/use_cases/reddit/reddit_restore_authentication.dart';
import 'NEW_ARCHITECTURE/presentation/bloc/submissions/submissions_bloc.dart';
import 'NEW_ARCHITECTURE/presentation/bloc/submissions_info/submissions_info_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc authentication
  sl.registerFactory(() => AuthenticationBloc(
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
  sl.registerFactory(() => SubmissionsBloc(getRedditSubredditsSubmissions: sl()));

  // Bloc submissions info
  sl.registerFactory(() => SubmissionsInfoBloc(redditRepository: sl()));

  // Bloc comments
  sl.registerFactory(() => CommentsBloc(sl()));

  // TODO: add subscriptions, which have yet to be fixed
  // bloc subscriptions

  // Use cases
  sl.registerLazySingleton(() => RedditAuthenticateUser(sl(), sl()));
  sl.registerLazySingleton(() => RedditAuthenticationUrl(sl()));
  sl.registerLazySingleton(() => RedditRestoreAuthentication(sl(), sl()));
  sl.registerLazySingleton(() => GetRedditSubredditsSubmissions(sl()));
  sl.registerLazySingleton(() => GetRedditSubreddits(sl()));
  sl.registerLazySingleton(() => GetRedditSubmission(sl()));
  sl.registerLazySingleton(() => GetRedditSubmissionComments(sl()));

  // Repository
  sl.registerLazySingleton<RedditRepository>(() => RedditRepositoryImpl(
      redditDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<StorageRepository>(() => StorageRepositoryImpl(
      storageDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<RedditDataSource>(() => RedditDataSource());
  sl.registerLazySingleton<StorageDataSource>(() => StorageDataSource(
      sharedPreferences: sl(),
    ),
  );

  //! Core

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}