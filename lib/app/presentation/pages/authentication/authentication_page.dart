import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/app/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:redditapp/app/presentation/bloc/authentication/authentication_state.dart';
import 'package:redditapp/app/presentation/bloc/navigation/navigation_bloc.dart';
import 'package:redditapp/app/presentation/bloc/navigation/navigation_event.dart';
import 'package:redditapp/app/presentation/bloc/navigation/navigation_state.dart';
import 'package:redditapp/app/presentation/pages/authentication/sign_in_widget.dart';
import 'package:redditapp/app/presentation/widgets/loading_widget.dart';

import 'package:redditapp/app/presentation/widgets/error_widget.dart';
import 'package:redditapp/core/errors/failures.dart';


import 'internal_web_widget.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      condition: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is NavigateHome) {
          Navigator.of(context).pushReplacementNamed('/');
        }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        condition: (previous, current) {
          return previous != current;
        },
        builder: (context, state) {
          print(state);
          if (state is Authenticated) {
            BlocProvider.of<NavigationBloc>(context).add(NavigateToHome());
            return Scaffold(body: LoadingWidget());
          } else if (state is NotAuthenticated) {
            return SignIn();
          } else if (state is LoadingAuthentication) {
            return Scaffold(body: LoadingWidget());
          } else if (state is StartedAuthentication) {
            return InternalWebView(
              url: (state.url),
            );
          }
          return ErrorContainer(GeneralFailure());
        },
      ),
    );
  }
}
