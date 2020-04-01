import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/reddit/reddit.dart';
import 'package:redditapp/repositories/reddit_repository.dart';
import './bloc_submissions.dart';

class SubmissionsBloc extends Bloc<SubmissionsEvent, SubmissionsState> {
  RedditRepository redditRepository;

  SubmissionsBloc({
      @required this.redditRepository,
  });

  @override
  SubmissionsState get initialState => InitialSubmissionsState();

  @override
  Stream<SubmissionsState> mapEventToState(
    SubmissionsEvent event,
  ) async* {
    if (event is GetHotSubmissions) {
      yield* _mapLoadSubmissionsToState(event, SubmissionOption.hot);
    } else if (event is GetNewestSubmissions) {
      yield* _mapLoadSubmissionsToState(event, SubmissionOption.newest);
    } else if (event is GetControversialSubmissions) {
      yield* _mapLoadSubmissionsToState(event, SubmissionOption.controversial);
    } else if (event is GetTopSubmissions) {
      yield* _mapLoadSubmissionsToState(event, SubmissionOption.top);
    }
  }

  Stream<SubmissionsState> _mapLoadSubmissionsToState(SubmissionsEvent event, SubmissionOption option) async* {
    List<Submission> submissions = await redditRepository.subredditsSubmissions(
      title: event.title,
      option: option,
    );

    yield SubmissionsLoaded(
      submissions: submissions,
    );
  }
}
