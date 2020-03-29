import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RestoreAuthentication extends AuthenticationEvent {}
class AuthenticateUser extends AuthenticationEvent {
  final String code;

  AuthenticateUser({
    @required this.code,
  });

  @override
  List<Object> get props => [code];
}
class StartAuthentication extends AuthenticationEvent {}
class StopAuthentication extends AuthenticationEvent {}
class NavigationComplete extends AuthenticationEvent {}
