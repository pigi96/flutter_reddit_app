import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/blocs/browse/bloc_browse.dart';

import 'browse_page.dart';

class BrowsePageGold extends StatefulWidget {
  @override
  _BrowsePageGoldState createState() => _BrowsePageGoldState();
}

class _BrowsePageGoldState extends State<BrowsePageGold> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrowseGoldBloc, BrowseState>(
      builder: (context, subredditsState) {
        return BrowsePage(
          subredditsState: subredditsState,
        );
      },
    );
  }
}
