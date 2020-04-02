import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/blocs/browse/bloc_browse.dart';

import 'browse_page.dart';

class BrowsePagePopular extends StatefulWidget {
  @override
  _BrowsePagePopularState createState() => _BrowsePagePopularState();
}

class _BrowsePagePopularState extends State<BrowsePagePopular> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrowsePopularBloc, BrowseState>(
      builder: (context, subredditsState) {
        return BrowsePage(
          subredditsState: subredditsState,
        );
      },
    );
  }
}
