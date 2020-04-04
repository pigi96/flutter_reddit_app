import 'package:draw/draw.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/NEW_ARCHITECTURE/data/models/reddit.dart';

abstract class BrowseState extends Equatable {
  final List<Subreddit> subreddits;

  BrowseState({
    @required this.subreddits,
  });

  @override
  List<Object> get props => [subreddits];
}

class InitialBrowseState extends BrowseState {}

class Subreddits extends BrowseState {
  Subreddits({
    subreddits,
  }) : super(
          subreddits: subreddits,
        );
}
