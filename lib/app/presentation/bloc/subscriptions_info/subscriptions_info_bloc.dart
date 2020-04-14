import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/app/data/models/reddit.dart';
import 'package:redditapp/app/domain/repositories/reddit_repository.dart';
import 'package:redditapp/app/domain/use_cases/reddit/post_reddit_subscribe.dart';
import './bloc_subscriptions_info.dart';

class SubscriptionsInfoBloc extends Bloc<SubscriptionsInfoEvent, SubscriptionsInfoState> {
  final RedditRepository redditRepository;
  final PostRedditSubscribe postRedditSubscribe;
  Subreddit subreddit;

  SubscriptionsInfoBloc({
    @required this.redditRepository,
    @required this.postRedditSubscribe,
    this.subreddit,
  });

  @override
  SubscriptionsInfoState get initialState => Subscribed(subreddit: subreddit);

  @override
  Stream<SubscriptionsInfoState> mapEventToState(
      SubscriptionsInfoEvent event,
  ) async* {
    if (event is Subscribe) {
      yield* _mapSubscribeToState(event);
    }
  }

  Stream<SubscriptionsInfoState> _mapSubscribeToState(Subscribe event) async* {
    final response = await postRedditSubscribe(Params(subreddit: event.subreddit, option: SubscribeOption.unsub));
    yield response.fold(
        (failure) => null,
        (subredditReceived) {
          return Subscribed(
            subreddit: subredditReceived,
          );
        },
    );
  }
}
