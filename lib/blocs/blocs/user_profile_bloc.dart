import 'dart:async';
import 'package:bloc/bloc.dart';
import '../bloc_user_profile.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  @override
  UserProfileState get initialState => InternalWebBrowserIsClosed();

  @override
  Stream<UserProfileState> mapEventToState(
    UserProfileEvent event,
  ) async* {
    if (event is OpenInternalWebBrowser) {
      yield* _mapOpenInternalWebBrowserToState();
    } else if (event is CloseInternalWebBrowser) {
      yield* _mapCloseInternalWebBrowserToState();
    }
  }

  Stream<UserProfileState> _mapOpenInternalWebBrowserToState() async* {
    yield InternalWebBrowserIsOpened();
  }

  Stream<UserProfileState> _mapCloseInternalWebBrowserToState() async* {
    yield InternalWebBrowserIsClosed();
  }
}
