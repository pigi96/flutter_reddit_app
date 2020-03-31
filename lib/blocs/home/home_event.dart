import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadSubredditsPopular extends HomeEvent {}
class LoadSubredditsNewest extends HomeEvent {}
class LoadSubredditsGold extends HomeEvent {}
class LoadSubredditsDefaults extends HomeEvent {}
