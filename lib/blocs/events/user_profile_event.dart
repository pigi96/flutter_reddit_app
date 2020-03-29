import 'package:equatable/equatable.dart';

abstract class UserProfileEvent extends Equatable {}
class OpenInternalWebBrowser extends UserProfileEvent {
  @override
  List<Object> get props => [];
}
class CloseInternalWebBrowser extends UserProfileEvent {
  @override
  List<Object> get props => [];
}