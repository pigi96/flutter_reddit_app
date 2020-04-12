import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redditapp/app/presentation/bloc/browse/browse_state.dart';
import 'package:redditapp/app/presentation/bloc/subscriptions/subscriptions_state.dart';
import 'package:redditapp/app/presentation/pages/browse/extended_card_widget.dart';
import 'package:redditapp/app/presentation/widgets/loading_widget.dart';

class SubscriptionsPageList extends StatefulWidget {
  final SubscriptionsState subscriptionsState;

  SubscriptionsPageList(this.subscriptionsState);

  @override
  _SubscriptionsPageListState createState() => _SubscriptionsPageListState();
}

class _SubscriptionsPageListState extends State<SubscriptionsPageList> {
  @override
  Widget build(BuildContext context) {
    if (widget.subscriptionsState is InitialSubscriptionsState) {
      return SliverToBoxAdapter(child: LoadingWidget());
    } else if (widget.subscriptionsState is Subscriptions) {
      final List<Subreddit> subreddits = widget.subscriptionsState.subreddits;
      return SliverList(
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            return ExtendedCardWidget(
              subreddit: subreddits[index],
            );
          },
          childCount: widget.subscriptionsState.subreddits.length,
        ),
      );
    } else {
      return SliverToBoxAdapter(
        child: LoadingWidget(),
      );
    }
  }
}
