import 'package:draw/draw.dart';

abstract class SubscriptionsInfoState {
  final Subreddit subreddit;
  SubscriptionsInfoState({
    this.subreddit,
  });
}

class Subscribed extends SubscriptionsInfoState {
  Subscribed({
    subreddit,
  }) : super(subreddit: subreddit);
}
