import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/app/data/models/reddit.dart';
import 'package:redditapp/app/domain/repositories/reddit_repository.dart';
import 'package:redditapp/app/domain/use_cases/reddit/get_reddit_subscriptions.dart';
import 'package:redditapp/core/errors/failures.dart';

import './bloc_subscriptions.dart';

class SubscriptionsBloc extends Bloc<SubscriptionsEvent, SubscriptionsState> {
  RedditRepository redditRepository;
  GetRedditSubscriptions getRedditSubscriptions;

  SubscriptionsBloc({
    @required this.redditRepository,
    @required this.getRedditSubscriptions,
  }) : assert(redditRepository != null), super(null);

  @override
  SubscriptionsState get initialState => InitialSubscriptionsState();

  @override
  Stream<SubscriptionsState> mapEventToState(
    SubscriptionsEvent event,
  ) async* {
    if (event is GetDefaultSubscriptions) {
      yield* _mapGetDefaultSubscriptionsToState();
    }
  }

  Stream<SubscriptionsState> _mapGetDefaultSubscriptionsToState() async* {
    final response = await getRedditSubscriptions(Params(option: SubscriptionOption.defaults));
    yield response.fold(
        (failure) => ErrorState(failure),
        (subscriptionsReceived) {
          return Subscriptions(
            subreddits: subscriptionsReceived,
          );
        },
    );
  }
}
