import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/blocs/browse/bloc_browse.dart';

import 'browse_page.dart';

class BrowsePageNewest extends StatefulWidget {
  @override
  _BrowsePageNewestState createState() => _BrowsePageNewestState();
}

class _BrowsePageNewestState extends State<BrowsePageNewest> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrowseNewestBloc, BrowseState>(
      builder: (context, subredditsState) {
        return BrowsePage(
          subredditsState: subredditsState,
        );
      },
    );
  }
}
