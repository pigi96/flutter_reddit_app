import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/app/domain/use_cases/reddit/reddit_authenticate_user.dart'
    as authUser;
import 'package:redditapp/app/domain/use_cases/reddit/reddit_restore_authentication.dart'
    as checkAuth;
import 'package:redditapp/app/domain/use_cases/reddit/reddit_authentication_url.dart'
    as authUrl;
import 'package:redditapp/core/use_cases/use_case.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  checkAuth.RedditRestoreAuthentication redditRestoreAuthentication;
  authUser.RedditAuthenticateUser redditAuthenticateUser;
  authUrl.RedditAuthenticationUrl redditAuthenticationUrl;

  AuthenticationBloc({
    @required this.redditRestoreAuthentication,
    @required this.redditAuthenticateUser,
    @required this.redditAuthenticationUrl,
  }) : assert(redditRestoreAuthentication != null &&
            redditAuthenticateUser != null &&
            redditAuthenticationUrl != null);

  @override
  AuthenticationState get initialState => NotAuthenticated();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is RestoreAuthentication) {
      yield* _mapRestoreAuthenticationToState();
    } else if (event is AuthenticateUser) {
      yield* _mapAuthenticateUserToState(event);
    } else if (event is StartAuthentication) {
      yield* _mapStartAuthenticationToState();
    } else if (event is StopAuthentication) {
      yield* _mapStopAuthenticationToState();
    }
  }

  Stream<AuthenticationState> _mapRestoreAuthenticationToState() async* {
    yield LoadingAuthentication();

    final authenticated = await redditRestoreAuthentication(NoParams());
    final yi = authenticated.fold(
      (failure) => NotAuthenticated(),
      (status) {
        return status ? Authenticated() : NotAuthenticated();
      },
    );

    yield yi;
  }

  Stream<AuthenticationState> _mapAuthenticateUserToState(
      AuthenticateUser event) async* {
    yield LoadingAuthentication();
    final authenticated =
        await redditAuthenticateUser(authUser.Params(code: event.code));
    yield authenticated.fold(
      (failure) => NotAuthenticated(),
      (status) {
        return Authenticated();
      },
    );
  }

  Stream<AuthenticationState> _mapStartAuthenticationToState() async* {
    final authenticationUrl = await redditAuthenticationUrl(NoParams());
    yield authenticationUrl.fold((failure) {
      return NotAuthenticated();
    }, (url) {
      return StartedAuthentication(url: url);
    });
  }

  Stream<AuthenticationState> _mapStopAuthenticationToState() async* {
    yield NotAuthenticated();
  }
}
