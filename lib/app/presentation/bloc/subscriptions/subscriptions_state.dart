import 'package:draw/draw.dart';
import 'package:equatable/equatable.dart';

abstract class SubscriptionsState extends Equatable {
  final List<Subreddit> subreddits;

  SubscriptionsState({
      this.subreddits,
  });

  @override
  List<Object> get props => [];
}

class InitialSubscriptionsState extends SubscriptionsState {}

class Subscriptions extends SubscriptionsState {
  Subscriptions({
    subreddits,
  }): super(
    subreddits: subreddits,
  );
}



