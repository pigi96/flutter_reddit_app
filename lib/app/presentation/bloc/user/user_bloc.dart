import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/app/domain/use_cases/reddit/get_reddit_redditor.dart';
import 'package:redditapp/app/domain/use_cases/reddit/revoke_redditor.dart';
import 'package:redditapp/core/use_cases/use_case.dart';
import './bloc_user.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetRedditRedditor getRedditRedditor;
  final RevokeRedditor revokeRedditor;

  UserBloc({
    @required this.getRedditRedditor,
    @required this.revokeRedditor,
  }) : super(InitialUserState());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is GetUserData) {
      yield* _mapGetUserDataToState();
    } else if (event is RevokeUser) {
      yield* _mapRevokeUserToState();
    }
  }

  Stream<UserState> _mapGetUserDataToState() async* {
    final response = await getRedditRedditor(NoParams());
    yield response.fold(
      (failure) => ErrorState(failure),
      (userDataReceived) => UserData(userDataReceived),
    );
  }

  Stream<UserState> _mapRevokeUserToState() async* {
    final response = await revokeRedditor(NoParams());
    yield response.fold(
      (failure) => ErrorState(failure),
      (revokedUser) => RevokedUser(),
    );
  }
}
