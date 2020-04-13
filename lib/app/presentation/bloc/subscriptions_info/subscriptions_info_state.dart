import 'package:meta/meta.dart';

@immutable
abstract class SubscriptionsInfoState {
  bool subscribed;
  SubscriptionsInfoState({this.subscribed});
}

class InitialSubscriptionsInfoState extends SubscriptionsInfoState {
  InitialSubscriptionsInfoState({
    subscribed,
  }):super(subscribed: subscribed);
}

class Subscribed extends SubscriptionsInfoState {
  Subscribed({
    subscribed,
  }) : super(subscribed: subscribed);
}