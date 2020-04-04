import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthenticationState {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthenticationState {}
class NotAuthenticated extends AuthenticationState {}
class LoadingAuthentication extends AuthenticationState {}
class StartedAuthentication extends AuthenticationState {
  final String url;

  StartedAuthentication({
    @required this.url,
  });

  @override
  List<Object> get props => [url];
}