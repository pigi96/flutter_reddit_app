import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/reddit/reddit.dart';
import 'package:redditapp/repositories/reddit_repository.dart';
import './bloc_home.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  RedditRepository redditRepository;

  HomeBloc({
    @required this.redditRepository,
  });

  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is LoadSubredditsPopular) {
      yield* _mapLoadSubredditsToState(SubredditOption.popular);
    } else if (event is LoadSubredditsNewest) {
      yield* _mapLoadSubredditsToState(SubredditOption.newest);
    } else if (event is LoadSubredditsGold) {
      yield* _mapLoadSubredditsToState(SubredditOption.gold);
    } else if (event is LoadSubredditsDefaults) {
      yield* _mapLoadSubredditsToState(SubredditOption.defaults);
    }
  }

  Stream<HomeState> _mapLoadSubredditsToState(SubredditOption option) async* {
    List<Subreddit> subreddits = await redditRepository.subreddits(
      option: option,
    );

    yield SubredditsLoaded(
      subreddits: subreddits,
    );

    yield* _mapLoadSubredditsToState(SubredditOption.popular);
  }
}
