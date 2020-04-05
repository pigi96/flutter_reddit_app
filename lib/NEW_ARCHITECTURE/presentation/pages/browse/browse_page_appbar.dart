import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/browse/bloc_browse.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/browse/browse_bloc.dart';

class BrowsePageAppbar extends StatefulWidget {
  @override
  _BrowsePageAppbarState createState() => _BrowsePageAppbarState();
}

class _BrowsePageAppbarState extends State<BrowsePageAppbar> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

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
