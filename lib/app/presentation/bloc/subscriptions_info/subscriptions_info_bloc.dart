import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/app/data/models/reddit.dart';
import 'package:redditapp/app/domain/repositories/reddit_repository.dart';
import 'package:redditapp/app/domain/use_cases/reddit/post_reddit_subscribe.dart';
import './bloc_subscriptions_info.dart';

class SubscriptionsInfoBloc extends Bloc<SubscriptionsInfoEvent, SubscriptionsInfoState> {
  RedditRepository redditRepository;
  PostRedditSubscribe postRedditSubscribe;

  SubscriptionsInfoBloc({
    @required this.redditRepository,
    @required this.postRedditSubscribe,
  });

  @override
  SubscriptionsInfoState get initialState => InitialSubscriptionsInfoState();

  @override
  Stream<SubscriptionsInfoState> mapEventToState(
      SubscriptionsInfoEvent event,
  ) async* {
    if (event is Subscribe) {
      yield* _mapSubscribeToState(event);
    }
  }

  Stream<SubscriptionsInfoState> _mapSubscribeToState(Subscribe event) async* {
    Subreddit subreddit = event.subreddit;
    final response = await postRedditSubscribe(Params(subreddit: subreddit, option: SubscribeOption.unsub));
    yield* response.fold(
        (failure) => null,
        (reponseReceived) {
          return null;
        },
    );
  }
}
