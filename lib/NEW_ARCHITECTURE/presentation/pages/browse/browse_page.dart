import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/browse/bloc_browse.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/browse/browse_bloc.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/browse/browse_state.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/widgets/extended_card_widget.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/widgets/loading_widget.dart';
import 'package:redditapp/injection_container.dart';

class BrowsePage extends StatefulWidget {
  @override
  _BrowsePageState createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BrowseBloc>(
      create: (context) => sl<BrowseBloc>()..add(GetPopularSubreddits()),
      child: BlocBuilder<BrowseBloc, BrowseState>(
        builder: (context, subredditsState) {
          print(subredditsState);
          BlocProvider.of<BrowseBloc>(context).add(GetPopularSubreddits());
          if (subredditsState is InitialBrowseState) {
            return LoadingWidget();
          } else if (subredditsState is Subreddits) {
            final List<Subreddit> subreddits = subredditsState.subreddits;
            return ListView(
              children: List.generate(
                subreddits.length,
                (index) {
                  return ExtendedCardWidget(
                    subreddit: subreddits[index],
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
