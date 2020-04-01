import 'package:equatable/equatable.dart';

abstract class BrowseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPopularSubreddits extends BrowseEvent {}
class GetNewestSubreddits extends BrowseEvent {}
class GetGoldSubreddits extends BrowseEvent {}
class GetDefaultsSubreddits extends BrowseEvent {}
