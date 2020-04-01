import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/reddit/reddit.dart';
import 'package:redditapp/repositories/reddit_repository.dart';
import './bloc_subscriptions.dart';

class SubscriptionsBloc extends Bloc<SubscriptionsEvent, SubscriptionsState> {
  RedditRepository redditRepository;

  SubscriptionsBloc({
    @required this.redditRepository,
  });

  @override
  SubscriptionsState get initialState => InitialSubscriptionsState();

  @override
  Stream<SubscriptionsState> mapEventToState(
    SubscriptionsEvent event,
  ) async* {
    if (event is GetDefaultSubscriptions) {
      yield* _mapGetDefaultSubscriptionsToState();
    } else if (event is GetContributorSubscriptions) {
      yield* _mapGetContributorSubscriptionsToState();
    } else if (event is GetModeratorSubscriptions) {
      yield* _mapGetModeratorSubscriptionsToState();
    }
  }

  Stream<SubscriptionsState> _mapGetDefaultSubscriptionsToState() async* {
    List<Subreddit> subreddits = await redditRepository.usersSubscriptions(
      option: SubscriptionOption.defaults,
    );

    yield DefaultSubscriptions(
      subreddits: subreddits,
    );
  }

  Stream<SubscriptionsState> _mapGetContributorSubscriptionsToState() async* {
    List<Subreddit> subreddits = await redditRepository.usersSubscriptions(
      option: SubscriptionOption.contributor,
    );

    yield DefaultSubscriptions(
      subreddits: subreddits,
    );
  }

  Stream<SubscriptionsState> _mapGetModeratorSubscriptionsToState() async* {
    List<Subreddit> subreddits = await redditRepository.usersSubscriptions(
      option: SubscriptionOption.moderator,
    );

    yield DefaultSubscriptions(
      subreddits: subreddits,
    );
  }
}
