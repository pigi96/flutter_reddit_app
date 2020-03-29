import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class NavigationState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialNavigationState extends NavigationState {}
class NavigateHome extends NavigationState {}