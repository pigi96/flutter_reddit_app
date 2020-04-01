import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/reddit/reddit.dart';
import 'package:redditapp/repositories/reddit_repository.dart';
import './bloc_browse.dart';

class BrowseBloc extends Bloc<BrowseEvent, BrowseState> {
  RedditRepository redditRepository;

  BrowseBloc({
    @required this.redditRepository,
  });

  @override
  BrowseState get initialState => InitialBrowseState();

  @override
  Stream<BrowseState> mapEventToState(
    BrowseEvent event,
  ) async* {
    if (event is GetPopularSubreddits) {
      yield* _mapLoadSubredditsToState(SubredditOption.popular);
    } else if (event is GetNewestSubreddits) {
      yield* _mapLoadSubredditsToState(SubredditOption.newest);
    } else if (event is GetGoldSubreddits) {
      yield* _mapLoadSubredditsToState(SubredditOption.gold);
    } else if (event is GetDefaultsSubreddits) {
      yield* _mapLoadSubredditsToState(SubredditOption.defaults);
    }
  }

  Stream<BrowseState> _mapLoadSubredditsToState(SubredditOption option) async* {
    List<Subreddit> subreddits = await redditRepository.subreddits(
      option: option,
    );

    yield SubredditsLoaded(
      subreddits: subreddits,
    );
  }
}
