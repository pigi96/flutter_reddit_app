import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/app/presentation/bloc/browse/bloc_browse.dart';
import 'package:redditapp/app/presentation/bloc/browse/browse_bloc.dart';
import 'package:redditapp/app_style/app_colors.dart';

class BrowsePageAppbar extends StatefulWidget {
  @override
  _BrowsePageAppbarState createState() => _BrowsePageAppbarState();
}

class _BrowsePageAppbarState extends State<BrowsePageAppbar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      snap: false,
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('RedDito'),
      ),
      backgroundColor: AppColors.redditOrange,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            return AwesomeDialog(
              context: context,
              animType: AnimType.BOTTOMSLIDE,
              dialogType: DialogType.INFO,
              body: Column(
                children: <Widget>[
                  FlatButton(
                    child: Text("Popular"),
                    onPressed: () {
                      BlocProvider.of<BrowseBloc>(context).add(GetPopularSubreddits());
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text("Newest"),
                    onPressed: () {
                      BlocProvider.of<BrowseBloc>(context).add(GetNewestSubreddits());
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text("Defaults"),
                    onPressed: () {
                      BlocProvider.of<BrowseBloc>(context).add(GetDefaultsSubreddits());
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              title: 'This is Ignored',
              desc:   'This is also Ignored',
              btnCancelOnPress: () {},
            ).show();
          },
        ),
      ],
    );
  }
}
