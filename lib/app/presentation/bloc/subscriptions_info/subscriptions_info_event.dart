import 'package:meta/meta.dart';
import 'package:draw/draw.dart';

@immutable
abstract class SubscriptionsInfoEvent {
  final Subreddit subreddit;
  SubscriptionsInfoEvent({this.subreddit});
}

class Subscribe extends SubscriptionsInfoEvent {
  Subscribe({subreddit}):super(subreddit:subreddit);
}
