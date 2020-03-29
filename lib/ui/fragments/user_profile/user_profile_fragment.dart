import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/blocs/bloc_authentication.dart';
import 'package:redditapp/blocs/bloc_user_profile.dart';
import 'package:redditapp/ui/widgets/internal_web_widget.dart';
import 'package:redditapp/ui/fragments/user_profile/user_profile_widget.dart';

class UserProfileFragment extends StatefulWidget {
  @override
  _UserProfileFragmentState createState() => _UserProfileFragmentState();
}

class _UserProfileFragmentState extends State<UserProfileFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<UserProfileBloc>(
            create: (BuildContext context) => UserProfileBloc(),
          ),
          BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) => AuthenticationBloc(),
          ),
        ],
        child: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, internalBrowser) {
            // explicit reddit actions
            if (internalBrowser is InternalWebBrowserIsOpened) {
              return InternalWebView(
                url: "asda",
              );
            }
            // default UI unless user is trying some explicit reddit actions
            return UserProfileView();
          },
        ),
      ),
    );
  }
}
