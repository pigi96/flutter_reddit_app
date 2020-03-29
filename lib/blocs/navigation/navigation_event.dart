import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class NavigationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NavigateToHome extends NavigationEvent {}
