import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:redditapp/blocs/bloc_authentication.dart';
import 'package:redditapp/ui/fragments/home.dart';
import 'package:redditapp/ui/widgets/error_widget.dart';
import 'package:redditapp/ui/widgets/internal_web_widget.dart';
import 'package:redditapp/ui/widgets/loading_widget.dart';
import 'package:redditapp/ui/widgets/sign_in_widget.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {

  @override
  void initState() {
    super.initState();
    Navigator.pushNamed(context, "/");
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(RestoreAuthentication());

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Authenticated) {
          /*SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushNamed('/');
          });*/
        } else if (state is NotAuthenticated) {
          return SignIn();
        } else if (state is LoadingAuthentication) {
          return LoadingWidget();
        } else if (state is StartedAuthentication) {
          return InternalWebView(
            url: (state.url),
          );
        }
        return ErrorContainer();
      },
    );
  }
}
