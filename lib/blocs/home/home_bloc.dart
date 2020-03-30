import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/repositories/reddit_repositroy.dart';
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
    if (event is LoadSubreddits) {
      yield* _mapLoadSubredditsToState();
    }
  }

  Stream<HomeState> _mapLoadSubredditsToState() async* {
    var listener = redditRepository.subreddits();

    List<Subreddit> subreddits = List<Subreddit>();
    await for (final value in listener) {
      // The `await .toList()` ensures the full list is ready
      // before yielding on the Stream
      subreddits.add(value);
    }

    yield SubredditsLoaded(
      subreddits: subreddits,
    );
  }
}
