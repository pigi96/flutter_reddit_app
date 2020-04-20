import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/app/domain/use_cases/reddit/get_reddit_redditor.dart';
import 'package:redditapp/core/use_cases/use_case.dart';
import './bloc_user.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetRedditRedditor getRedditRedditor;
  UserBloc({@required this.getRedditRedditor});

  @override
  UserState get initialState => InitialUserState();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is GetUserData) {
      yield* _mapGetUserDataToState();
    }
  }

  Stream<UserState> _mapGetUserDataToState() async* {
    final response = await getRedditRedditor(NoParams());
    yield response.fold(
      (failure) => ErrorState(failure),
      (userDataReceived) => UserData(userDataReceived),
    );
  }
}
