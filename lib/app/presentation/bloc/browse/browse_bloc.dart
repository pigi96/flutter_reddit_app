import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/app/data/models/reddit.dart';
import 'package:redditapp/app/domain/use_cases/reddit/get_reddit_subreddits.dart';

import './bloc_browse.dart';

class BrowseBloc extends Bloc<BrowseEvent, BrowseState> {
  GetRedditSubreddits getRedditSubreddits;

  BrowseBloc({
    @required this.getRedditSubreddits,
  }) : assert(getRedditSubreddits != null);

  @override
  BrowseState get initialState => InitialBrowseState();

  @override
  Stream<BrowseState> mapEventToState(
    BrowseEvent event,
  ) async* {
    if (event is GetPopularSubreddits) {
      yield* _mapSubredditsToState(BrowseOption.popular);
    } else if (event is GetNewestSubreddits) {
      yield* _mapSubredditsToState(BrowseOption.newest);
    } else if (event is GetDefaultsSubreddits) {
      yield* _mapSubredditsToState(BrowseOption.defaults);
    } else if (event is GetGoldSubreddits) {
      yield* _mapSubredditsToState(BrowseOption.gold);
    }
  }

  Stream<BrowseState> _mapSubredditsToState(BrowseOption option) async* {
    yield Loading();
    final getSubreddits = await getRedditSubreddits(Params(option: option));
    yield getSubreddits.fold(
      (failure) => ErrorState(
        failure: failure,
      ),
      (subredditsReceived) => Subreddits(
        subreddits: subredditsReceived,
      ),
    );
  }
}
