import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/app/presentation/bloc/subscriptions/subscriptions_state.dart';
import 'package:redditapp/app/presentation/bloc/subscriptions_info/bloc_subscriptions_info.dart';
import 'package:redditapp/app/presentation/widgets/loading_widget.dart';
import 'package:redditapp/injection_container.dart';

import 'extended_card_widget.dart';

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
            return BlocProvider<SubscriptionsInfoBloc>(
              create: (context) => sl.get<SubscriptionsInfoBloc>(param1: subreddits[index]),
              child: ExtendedCardWidget(),
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
