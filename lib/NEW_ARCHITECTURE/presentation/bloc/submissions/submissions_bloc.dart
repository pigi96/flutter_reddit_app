import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/NEW_ARCHITECTURE/data/models/reddit.dart';
import 'package:redditapp/NEW_ARCHITECTURE/domain/use_cases/reddit/get_reddit_subreddits_submissions.dart';
import './bloc_submissions.dart';

abstract class SubmissionsBloc extends Bloc<SubmissionsEvent, SubmissionsState> {
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
    }
  }

  // Keep list to save and call "next" on pages
  List<Submission> submissionsSaved = List<Submission>();
  String fullname = "";

  Stream<SubmissionsState> _mapSubmissionsToState(SubmissionsEvent event, SubmissionOption option) async* {

    final getSubmissions = await getRedditSubredditsSubmissions(Params(
      title: event.title,
      option: option,
      after: fullname,
    ));
    yield getSubmissions.fold(
          (failure) => null,
          (status) {
            submissionsSaved.addAll(status);
        return Submissions(
          submissions: status,
        );
      },
    );
  }
}

class SubmissionsHotBloc extends SubmissionsBloc {
  SubmissionsHotBloc({
    getRedditSubredditsSubmissions,
  }) : super(
    getRedditSubredditsSubmissions: getRedditSubredditsSubmissions,
  );
}

class SubmissionsNewestBloc extends SubmissionsBloc {
  SubmissionsNewestBloc({
    getRedditSubredditsSubmissions,
  }) : super(
    getRedditSubredditsSubmissions: getRedditSubredditsSubmissions,
  );
}

class SubmissionsControversialBloc extends SubmissionsBloc {
  SubmissionsControversialBloc({
    getRedditSubredditsSubmissions,
  }) : super(
    getRedditSubredditsSubmissions: getRedditSubredditsSubmissions,
  );
}

class SubmissionsTopBloc extends SubmissionsBloc {
  SubmissionsTopBloc({
    getRedditSubredditsSubmissions,
  }) : super(
    getRedditSubredditsSubmissions: getRedditSubredditsSubmissions,
  );
}