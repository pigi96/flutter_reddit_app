import 'package:draw/draw.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

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

class Loading extends BrowseState {

}
