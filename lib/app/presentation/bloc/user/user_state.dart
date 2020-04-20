import 'package:draw/draw.dart';
import 'package:meta/meta.dart';
import 'package:redditapp/core/errors/failures.dart';

abstract class UserState {}

class InitialUserState extends UserState {}

class UserData extends UserState {
  final Redditor redditor;
  UserData(this.redditor);
}

class ErrorState extends UserState {
  Failure failure;
  ErrorState(this.failure);
}
