import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/blocs/bloc_authentication.dart';
import 'package:redditapp/storage/storage.dart';
import 'package:redditapp/ui/fragments/home.dart';
import 'package:redditapp/ui/pages/authentication_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(),
        ),
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
        ),
      ],
      child: MaterialApp(
        routes: {
          "/authentication": (context) {
            BlocProvider.of<AuthenticationBloc>(context).add(RestoreAuthentication());
            return AuthenticationPage();
          },
          "/": (context) =>
            Home(),
        },
        initialRoute: "/authentication",
      ),
    );
  }
}
