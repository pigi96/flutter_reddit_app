import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/app/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:redditapp/app/presentation/bloc/authentication/authentication_event.dart';
import 'package:redditapp/app_style/app_colors.dart';

class SignIn extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.redditWhite,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton.icon(
                onPressed: () => BlocProvider.of<AuthenticationBloc>(context).add(StartAuthentication()),
                icon: Icon(
                  Icons.person,
                  size: 35.0,
                  color: AppColors.redditWhite,
                ),
                label: Text(
                  "Reddit",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: AppColors.redditWhite,
                  ),
                ),
                color: AppColors.redditOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                "To start using the app you have to login using your reddit account.",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30.0,
              ),
              RaisedButton.icon(
                onPressed: () => Navigator.pushReplacementNamed(context, "/"),
                icon: Icon(
                  Icons.apps,
                  size: 35.0,
                  color: AppColors.redditWhite,
                ),
                label: Text(
                  "Continue w/o reddit",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: AppColors.redditWhite,
                  ),
                ),
                color: AppColors.redditOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
