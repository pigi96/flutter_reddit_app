import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/blocs/authentication/bloc_authentication.dart';
import 'package:redditapp/repositories/reddit_repository.dart';
import 'package:redditapp/repositories/storage_repository.dart';
import 'package:redditapp/storage/storage.dart';
import 'package:redditapp/ui/fragments/home.dart';
import 'package:redditapp/ui/pages/authentication_page.dart';
import 'package:redditapp/ui/pages/subreddit_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocs/home/home_bloc.dart';
import 'blocs/home/home_event.dart';
import 'blocs/navigation/navigation_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Storage.instance.prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Inject BLoCs' that will be required over the whole app
    // cycle, all reddits' BLoCs' should be injected here, since
    // they are usually required through the whole app
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(
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
          "/subreddit": (context) {
            return SubredditPage();
          },
          "/authentication": (context) {
            BlocProvider.of<AuthenticationBloc>(context).add(
                RestoreAuthentication());
            return AuthenticationPage();
          },
          "/": (context) {
            BlocProvider.of<HomeBloc>(context).add(LoadSubredditsPopular());
            return Home();
          },
        },
        initialRoute: "/authentication",
      ),
    );
  }
}
