import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/app/data/models/reddit.dart';
import 'package:redditapp/app/data/repositories/reddit_repository_impl.dart';
import 'package:redditapp/app/domain/repositories/reddit_repository.dart';
import './bloc_subscriptions.dart';

class SubscriptionsBloc extends Bloc<SubscriptionsEvent, SubscriptionsState> {
  RedditRepository redditRepository;

  SubscriptionsBloc({
    @required this.redditRepository,
  }) : assert(redditRepository != null);

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
    /*List<Subreddit> subreddits = await redditRepository.usersSubscriptions(
      option: SubscriptionOption.defaults,
    );*/

    yield DefaultSubscriptions(
      //subreddits: subreddits,
    );
  }

  Stream<SubscriptionsState> _mapGetContributorSubscriptionsToState() async* {
    /*List<Subreddit> subreddits = await redditRepository.usersSubscriptions(
      option: SubscriptionOption.contributor,
    );*/

    yield ContributorSubscriptions(
      //subreddits: subreddits,
    );
  }

  Stream<SubscriptionsState> _mapGetModeratorSubscriptionsToState() async* {
    /*List<Subreddit> subreddits = await redditRepository.usersSubscriptions(
      option: SubscriptionOption.moderator,
    );*/

    yield ModeratorSubscriptions(
      //subreddits: subreddits,
    );
  }
}
