import 'package:draw/draw.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class BrowseState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialBrowseState extends BrowseState {}

class Subreddits extends BrowseState {
  final List<Subreddit> subreddits;

  Subreddits({
    @required this.subreddits,
  });

  @override
  List<Object> get props => [subreddits];
}
