import 'package:auto_size_text/auto_size_text.dart';
import 'package:draw/draw.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/blocs/browse/bloc_browse.dart';
import 'package:redditapp/reddit/reddit.dart';
import 'package:redditapp/ui/widgets/extended_card_widget.dart';
import 'package:redditapp/ui/widgets/loading_widget.dart';

class BrowsePage extends StatefulWidget {
  final BrowseState subredditsState;

  BrowsePage({
    @required this.subredditsState,
  });

  @override
  _BrowsePageState createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  @override
  Widget build(BuildContext context) {
    if (widget.subredditsState is InitialBrowseState) {
      return LoadingWidget();
    } else if (widget.subredditsState is Subreddits) {
      final List<Subreddit> subreddits = widget.subredditsState.subreddits;
      return ListView(
        children: List.generate(
          subreddits.length, (index) {
            return ExtendedCardWidget(
              subreddit: widget.subredditsState.subreddits[index],
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }
}
