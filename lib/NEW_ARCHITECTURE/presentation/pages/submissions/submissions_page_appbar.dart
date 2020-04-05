import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/browse/bloc_browse.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/browse/browse_bloc.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/submissions/submissions_bloc.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/submissions/submissions_event.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/submissions/submissions_state.dart';

class SubmissionsPageAppbar extends StatefulWidget {
  final Subreddit subreddit;

  SubmissionsPageAppbar(this.subreddit);

  @override
  _SubmissionsPageAppbarState createState() => _SubmissionsPageAppbarState();
}

class _SubmissionsPageAppbarState extends State<SubmissionsPageAppbar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      snap: false,
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('Demo'),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            return AwesomeDialog(
              context: context,
              animType: AnimType.BOTTOMSLIDE,
              dialogType: DialogType.INFO,
              body: Column(
                children: <Widget>[
                  FlatButton(
                    child: Text("Hot"),
                    onPressed: () {
                      BlocProvider.of<SubmissionsBloc>(context).add(RefreshSubmissions());
                      BlocProvider.of<SubmissionsBloc>(context).add(GetHotSubmissions(
                        title: widget.subreddit.displayName,
                      ));
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text("Newest"),
                    onPressed: () {
                      BlocProvider.of<SubmissionsBloc>(context).add(RefreshSubmissions());
                      BlocProvider.of<SubmissionsBloc>(context).add(GetNewestSubmissions(
                        title: widget.subreddit.displayName,
                      ));
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text("Top"),
                    onPressed: () {
                      BlocProvider.of<SubmissionsBloc>(context).add(RefreshSubmissions());
                      BlocProvider.of<SubmissionsBloc>(context).add(GetTopSubmissions(
                        title: widget.subreddit.displayName,
                      ));
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              tittle: 'This is Ignored',
              desc:   'This is also Ignored',
              btnCancelOnPress: () {},
            ).show();
          },
        ),
      ],
    );
  }
}
