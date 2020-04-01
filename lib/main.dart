
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/blocs/authentication/bloc_authentication.dart';
import 'package:redditapp/repositories/reddit_repository.dart';
import 'package:redditapp/repositories/storage_repository.dart';
import 'package:redditapp/storage/storage.dart';
import 'package:redditapp/ui/pages/home.dart';
import 'package:redditapp/ui/pages/authentication/authentication_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'blocs/browse/browse_bloc.dart';
import 'blocs/browse/browse_event.dart';
import 'blocs/navigation/navigation_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Storage.instance.prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Inject all repositories into the global project, since they are required
    // to be used over a lot of different pages.
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<RedditRepository>(
          create: (BuildContext context) => RedditRepository(),
        ),
        RepositoryProvider<StorageRepository>(
          create: (BuildContext context) => StorageRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<BrowseBloc>(
            create: (context) => BrowseBloc(
              redditRepository: RedditRepository(),
            ),
          ),
          BlocProvider<NavigationBloc>(
            create: (context) => NavigationBloc(),
          ),
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              redditRepository: RedditRepository(),
              storageRepository: StorageRepository(),
            ),
          ),
        ],
        child: MaterialApp(
          routes: {
            "/authentication": (context) {
              BlocProvider.of<AuthenticationBloc>(context).add(
                  RestoreAuthentication());
              return AuthenticationPage();
            },
            "/": (context) {
              BlocProvider.of<BrowseBloc>(context).add(GetPopularSubreddits());
              return Home();
            },
          },
          initialRoute: "/authentication",
        ),
      ),
    );
  }
}
