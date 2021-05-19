import 'dart:async';
import 'package:bloc/bloc.dart';
import 'bloc_navigation.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc(NavigationState initialState) : super(initialState);

  @override
  NavigationState get initialState => InitialNavigationState();

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    if (event is NavigateToHome) {
      yield* _mapNavigateToHomeToState();
    }
  }

  Stream<NavigationState> _mapNavigateToHomeToState() async* {
    yield NavigateHome();
  }
}
