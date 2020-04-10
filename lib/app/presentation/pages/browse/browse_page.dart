import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/app/presentation/bloc/browse/bloc_browse.dart';
import 'package:redditapp/app/presentation/bloc/browse/browse_bloc.dart';
import 'package:redditapp/app/presentation/bloc/browse/browse_state.dart';
import 'package:redditapp/injection_container.dart';

import 'browse_page_appbar.dart';
import 'browse_page_list.dart';

class BrowsePage extends StatefulWidget {
  @override
  _BrowsePageState createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BrowseBloc>(
      create: (context) => sl<BrowseBloc>()..add(GetPopularSubreddits()),
      child: BlocBuilder<BrowseBloc, BrowseState>(
        builder: (context, subredditsState) {
          return Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                BrowsePageAppbar(),
                BrowsePageList(subredditsState),
              ],
            ),
          );
        },
      ),
    );
  }
}