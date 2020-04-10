import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/app/data/models/reddit.dart';
import 'package:redditapp/app/domain/use_cases/reddit/get_reddit_subreddits_submissions.dart';
import './bloc_submissions.dart';

class SubmissionsBloc extends Bloc<SubmissionsEvent, SubmissionsState> {
  GetRedditSubredditsSubmissions getRedditSubredditsSubmissions;

  SubmissionsBloc({
    @required this.getRedditSubredditsSubmissions,
  }) : assert(getRedditSubredditsSubmissions != null);

  @override
  SubmissionsState get initialState => InitialSubmissionsState();

  @override
  Stream<SubmissionsState> mapEventToState(
    SubmissionsEvent event,
  ) async* {
    if (event is GetHotSubmissions) {
      yield* _mapSubmissionsToState(event, SubmissionOption.hot);
    } else if (event is GetNewestSubmissions) {
      yield* _mapSubmissionsToState(event, SubmissionOption.newest);
    } else if (event is GetControversialSubmissions) {
      yield* _mapSubmissionsToState(event, SubmissionOption.controversial);
    } else if (event is GetTopSubmissions) {
      yield* _mapSubmissionsToState(event, SubmissionOption.top);
    } else if (event is RefreshSubmissions) {
      submissionsSaved.clear();
      fullname = "";
      yield LoadingSubmissions();
    }
  }

  // Keep list to save and call "next" on pages
  List<Submission> submissionsSaved = List<Submission>();
  String fullname = "";

  Stream<SubmissionsState> _mapSubmissionsToState(
      SubmissionsEvent event, SubmissionOption option) async* {
    final getSubmissions = await getRedditSubredditsSubmissions(Params(
      title: event.title,
      option: option,
      after: fullname,
    ));
    yield getSubmissions.fold(
      (failure) => null,
      (submissionsReceived) {
        submissionsSaved.addAll(submissionsReceived);
        fullname = submissionsReceived.length > 0 ? fullname = submissionsReceived.last.fullname: "";
        return Submissions(
          submissions: submissionsSaved,
          submissionsEvent: event,
        );
      },
    );
  }
}
