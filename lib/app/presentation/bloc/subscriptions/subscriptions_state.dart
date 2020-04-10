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

class DefaultSubscriptions extends SubscriptionsState {
  DefaultSubscriptions({
    subreddits,
  }): super(
    subreddits: subreddits,
  );
}

class ContributorSubscriptions extends SubscriptionsState {
  ContributorSubscriptions({
    subreddits,
  }): super(
    subreddits: subreddits,
  );
}

class ModeratorSubscriptions extends SubscriptionsState {
  ModeratorSubscriptions({
    subreddits,
  }): super(
    subreddits: subreddits,
  );
}



