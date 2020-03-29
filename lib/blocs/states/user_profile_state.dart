import 'package:equatable/equatable.dart';

abstract class UserProfileState extends Equatable {
  @override
  List<Object> get props => [];
}
class InternalWebVrowserIsLoading extends UserProfileState {}
class InternalWebBrowserIsOpened extends UserProfileState {
  String url;
}
class InternalWebBrowserIsClosed extends UserProfileState {}
