import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/blocs/browse/bloc_browse.dart';

import 'browse_page.dart';

class BrowsePageDefaults extends StatefulWidget {
  @override
  _BrowsePageDefaultsState createState() => _BrowsePageDefaultsState();
}

class _BrowsePageDefaultsState extends State<BrowsePageDefaults> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrowseDefaultsBloc, BrowseState>(
      builder: (context, subredditsState) {
        return BrowsePage(
          subredditsState: subredditsState,
        );
      },
    );
  }
}
