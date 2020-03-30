import 'package:draw/draw.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialHomeState extends HomeState {}
class SubredditsLoaded extends HomeState {
  final List<Subreddit> subreddits;

  SubredditsLoaded({
      @required this.subreddits,
  });

  @override
  List<Object> get props => [subreddits];
}
