import 'package:get_it/get_it.dart';
import 'package:redditapp/NEW_ARCHITECTURE/data/repositories/reddit_repository_impl.dart';
import 'package:redditapp/NEW_ARCHITECTURE/data/repositories/storage_repository_impl.dart';
import 'package:redditapp/NEW_ARCHITECTURE/domain/usecases/reddit/reddit_authentication_url.dart';
import 'package:redditapp/NEW_ARCHITECTURE/domain/usecases/reddit/reddit_restore_authentication.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/browse/bloc_browse.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/navigation/bloc_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'NEW_ARCHITECTURE/data/datasources/reddit_data_source.dart';
import 'NEW_ARCHITECTURE/data/datasources/storage_data_source.dart';
import 'NEW_ARCHITECTURE/domain/repositories/reddit_repository.dart';
import 'NEW_ARCHITECTURE/domain/repositories/storage_repository.dart';
import 'NEW_ARCHITECTURE/domain/usecases/reddit/reddit_authenticate_user.dart';
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
  sl.registerFactory(() => BrowsePopularBloc(redditRepository: sl()));
  sl.registerFactory(() => BrowseDefaultsBloc(redditRepository: sl()));
  sl.registerFactory(() => BrowseGoldBloc(redditRepository: sl()));
  sl.registerFactory(() => BrowseNewestBloc(redditRepository: sl()));

  // Bloc submissions
  sl.registerFactory(() => SubmissionsHotBloc(redditRepository: sl()));
  sl.registerFactory(() => SubmissionsNewestBloc(redditRepository: sl()));
  sl.registerFactory(() => SubmissionsControversialBloc(redditRepository: sl()));
  sl.registerFactory(() => SubmissionsTopBloc(redditRepository: sl()));

  // Bloc submissions info
  sl.registerFactory(() => SubmissionsInfoBloc(redditRepository: sl()));

  // TODO: add subscriptions, which have yet to be fixed
  // bloc subscriptions

  // Use cases
  sl.registerLazySingleton(() => RedditAuthenticateUser(sl()));
  sl.registerLazySingleton(() => RedditAuthenticationUrl(sl()));
  sl.registerLazySingleton(() => RedditRestoreAuthentication(sl()));

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
  sl.registerLazySingleton<RedditDataSource>(() => RedditDataSource(
      storageRepository: sl(),
  ),);
  sl.registerLazySingleton<StorageDataSource>(() => StorageDataSource(
      sharedPreferences: sl(),
    ),
  );

  //! Core

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}