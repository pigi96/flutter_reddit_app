import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/app/presentation/bloc/browse/bloc_browse.dart';
import 'package:redditapp/app/presentation/bloc/browse/browse_state.dart';
import 'package:redditapp/app/presentation/bloc/subscriptions_info/subscriptions_info_bloc.dart';
import 'package:redditapp/app/presentation/pages/browse/extended_card_widget.dart';
import 'package:redditapp/app/presentation/widgets/error_widget.dart';
import 'package:redditapp/app/presentation/widgets/loading_widget.dart';

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
    final browseState = widget.browseState;
    print(browseState);
    if (browseState is InitialBrowseState) {
      return SliverToBoxAdapter(child: LoadingWidget());
    } else if (browseState is Subreddits) {
      final List<Subreddit> subreddits = browseState.subreddits;
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return BlocProvider<SubscriptionsInfoBloc>(
              create: (context) =>
                  sl.get<SubscriptionsInfoBloc>(param1: subreddits[index]),
              child: ExtendedCardWidget(),
            );
          },
          childCount: browseState.subreddits.length,
        ),
      );
    } else if (browseState is ErrorState) {
      return SliverFillRemaining(
        child: ErrorContainer(
          browseState.failure,
          action: BlocProvider.of<BrowseBloc>(context),
          event: GetPopularSubreddits(),
        ),
      );
    } else {
      return SliverFillRemaining(
        child: LoadingWidget(),
      );
    }
  }
}
