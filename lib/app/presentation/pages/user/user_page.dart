import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/app/presentation/bloc/user/bloc_user.dart';
import 'package:redditapp/app/presentation/widgets/loading_widget.dart';
import 'package:redditapp/app_style/app_colors.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(GetUserData());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.redditOrange,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          if (userState is InitialUserState) {
            return LoadingWidget();
          } else if (userState is UserData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Icon(Icons.account_circle, size: 75.0, color: AppColors.redditBlueDark,),
                      Text(userState.redditor.displayName, style: TextStyle(fontSize: 30.0),),
                      Text("Unread msgs: ${userState.redditor.inboxCount}"),
                      Text("Karma: ${userState.redditor.commentKarma}"),
                    ],
                  ),
                  RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 2.0,
                    color: AppColors.redditBlueDark,
                    onPressed: () {

                    },
                    icon: Icon(Icons.close, color: Colors.white,),
                    label: Text("Logout", style: TextStyle(color: Colors.white),),
                  )
                ],
              ),
            );
          } else {
            return LoadingWidget();
          }
        },
      ),
    );
  }
}
