import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/blocs/navigation/navigation_bloc.dart';
import 'package:redditapp/repositories/reddit_repository.dart';
import 'package:redditapp/repositories/storage_repository.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';


class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  RedditRepository redditRepository;
  StorageRepository storageRepository;

  AuthenticationBloc({
    @required this.redditRepository,
    @required this.storageRepository,
  });

  @override
  AuthenticationState get initialState => NotAuthenticated();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
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

    bool authenticated = await redditRepository.restoreRedditAuthentication(
      storageRepository: storageRepository,
    );

    yield authenticated ? Authenticated():
                          NotAuthenticated();
  }

  Stream<AuthenticationState> _mapAuthenticateUserToState(AuthenticateUser event) async* {
    yield LoadingAuthentication();

    bool authenticated = await redditRepository.authenticateUser(
      storageRepository: storageRepository,
      code: event.code,
    );

    yield authenticated ? Authenticated():
                          NotAuthenticated();
  }

  Stream<AuthenticationState> _mapStartAuthenticationToState() async* {
    yield StartedAuthentication(
      url: redditRepository.authenticationUrl().toString(),
    );
  }

  Stream<AuthenticationState> _mapStopAuthenticationToState() async* {
    yield NotAuthenticated();
  }
}