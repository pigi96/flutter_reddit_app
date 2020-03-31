import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/reddit/reddit.dart';
import 'package:redditapp/repositories/reddit_repository.dart';
import './bloc_submission.dart';

class SubmissionBloc extends Bloc<SubmissionEvent, SubmissionState> {
  RedditRepository redditRepository;

  SubmissionBloc({
      @required this.redditRepository,
  });

  @override
  SubmissionState get initialState => InitialSubmissionState();

  @override
  Stream<SubmissionState> mapEventToState(
    SubmissionEvent event,
  ) async* {
    if (event is LoadSubmissionsHot) {
      yield* _mapLoadSubmissionsToState(event, SubmissionOption.hot);
    } else if (event is LoadSubmissionsNewest) {
      yield* _mapLoadSubmissionsToState(event, SubmissionOption.newest);
    } else if (event is LoadSubmissionsControversial) {
      yield* _mapLoadSubmissionsToState(event, SubmissionOption.controversial);
    } else if (event is LoadSubmissionsTop) {
      yield* _mapLoadSubmissionsToState(event, SubmissionOption.top);
    }
  }

  Stream<SubmissionState> _mapLoadSubmissionsToState(SubmissionEvent event, SubmissionOption option) async* {
    List<Submission> submissions = await redditRepository.subredditsSubmissions(
      title: event.title,
      option: option,
    );

    yield SubmissionsLoaded(
      submissions: submissions,
    );
  }
}
