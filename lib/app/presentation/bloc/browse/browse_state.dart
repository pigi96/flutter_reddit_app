import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/app/presentation/bloc/base_state.dart';
import 'package:redditapp/core/errors/failures.dart';

abstract class BrowseState {
  final List<Subreddit> subreddits;

  BrowseState({
    @required this.subreddits,
  });
}

class InitialBrowseState extends BrowseState {}

class Subreddits extends BrowseState {
  Subreddits({
    subreddits
  }) : super(subreddits : subreddits);
}

class Loading extends BrowseState {}
class ErrorState extends BrowseState {
  Failure failure;
  ErrorState({
    @required this.failure,
  });
}

