import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/browse/browse_bloc.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/browse/browse_event.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/browse/browse_state.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/widgets/extended_card_widget.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/widgets/loading_widget.dart';

import '../../../../injection_container.dart';

class BrowsePageList extends StatefulWidget {
  final BrowseState browseState;

  BrowsePageList(this.browseState);

  @override
  _BrowsePageListState createState() => _BrowsePageListState();
}

class _BrowsePageListState extends State<BrowsePageList> {
  @override
  Widget build(BuildContext context) {
    if (widget.browseState is InitialBrowseState) {
      return SliverToBoxAdapter(child: LoadingWidget());
    } else if (widget.browseState is Subreddits) {
      final List<Subreddit> subreddits = widget.browseState.subreddits;
      return SliverList(
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            return ExtendedCardWidget(
              subreddit: subreddits[index],
            );
          },
          childCount: widget.browseState.subreddits.length,
        ),
      );
    } else {
      return SliverToBoxAdapter(
        child: LoadingWidget(),
      );
    }
  }
}
