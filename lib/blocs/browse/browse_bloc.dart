import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/reddit/reddit.dart';
import 'package:redditapp/repositories/reddit_repository.dart';
import './bloc_browse.dart';

abstract class BrowseBloc extends Bloc<BrowseEvent, BrowseState> {
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
    List<Subreddit> subreddits = await redditRepository.subreddits(
      option: option,
    );

    yield Subreddits(
      subreddits: subreddits,
    );
  }
}

class BrowsePopularBloc extends BrowseBloc {
  BrowsePopularBloc({
    redditRepository,
  }) : super(
          redditRepository: redditRepository,
        );
}

class BrowseNewestBloc extends BrowseBloc {
  BrowseNewestBloc({
    redditRepository,
  }) : super(
          redditRepository: redditRepository,
        );
}

class BrowseGoldBloc extends BrowseBloc {
  BrowseGoldBloc({
    redditRepository,
  }) : super(
          redditRepository: redditRepository,
        );
}

class BrowseDefaultsBloc extends BrowseBloc {
  BrowseDefaultsBloc({
    redditRepository,
  }) : super(
          redditRepository: redditRepository,
        );
}
