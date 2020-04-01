import 'package:equatable/equatable.dart';

abstract class SubscriptionsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDefaultSubscriptions extends SubscriptionsEvent {}
class GetContributorSubscriptions extends SubscriptionsEvent {}
class GetModeratorSubscriptions extends SubscriptionsEvent {}
