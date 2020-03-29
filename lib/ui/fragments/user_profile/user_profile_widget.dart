import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/blocs/bloc_authentication.dart';
import 'package:redditapp/blocs/bloc_user_profile.dart';
import 'package:redditapp/blocs/blocs/user_profile_bloc.dart';

class UserProfileView extends StatefulWidget {
  @override
  _UserProfileView createState() => _UserProfileView();
}

class _UserProfileView extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    // Try to restore previous authentication state
    BlocProvider.of<AuthenticationBloc>(context).add(RestoreAuthentication());

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("ASD"),
            RaisedButton.icon(
              onPressed: () => BlocProvider.of<UserProfileBloc>(context).add(OpenInternalWebBrowser()),
              icon: Icon(Icons.android),
              label: Text("Yes mam!"),
              ),
          ],
        ),
      ),
    );
  }
}
