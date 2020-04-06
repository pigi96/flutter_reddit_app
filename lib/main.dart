import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'NEW_ARCHITECTURE/presentation/bloc/authentication/authentication_bloc.dart';
import 'NEW_ARCHITECTURE/presentation/bloc/authentication/authentication_event.dart';
import 'NEW_ARCHITECTURE/presentation/bloc/navigation/navigation_bloc.dart';
import 'NEW_ARCHITECTURE/presentation/pages/authentication/authentication_page.dart';
import 'NEW_ARCHITECTURE/presentation/pages/home.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Inject all repositories into the global project, since they are required
    // to be used over a lot of different pages.
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          create: (context) => di.sl<NavigationBloc>(),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => di.sl<AuthenticationBloc>(),
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
            return Home();
          },
        },
        initialRoute: "/authentication",
      ),
    );
  }
}
