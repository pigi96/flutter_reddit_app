import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redditapp/app/presentation/bloc/browse/browse_state.dart';
import 'package:redditapp/app/presentation/pages/browse/extended_card_widget.dart';
import 'package:redditapp/app/presentation/widgets/loading_widget.dart';

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
