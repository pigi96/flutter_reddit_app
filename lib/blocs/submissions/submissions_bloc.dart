import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/reddit/reddit.dart';
import 'package:redditapp/repositories/reddit_repository.dart';
import './bloc_submissions.dart';

abstract class SubmissionsBloc extends Bloc<SubmissionsEvent, SubmissionsState> {
  RedditRepository redditRepository;

  var groupLoaded = 0;

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
      yield* _mapSubmissionsToState(event, SubmissionOption.hot);
    } else if (event is GetNewestSubmissions) {
      yield* _mapSubmissionsToState(event, SubmissionOption.newest);
    } else if (event is GetControversialSubmissions) {
      yield* _mapSubmissionsToState(event, SubmissionOption.controversial);
    } else if (event is GetTopSubmissions) {
      yield* _mapSubmissionsToState(event, SubmissionOption.top);
    }
  }

  Stream<SubmissionsState> _mapSubmissionsToState(SubmissionsEvent event, SubmissionOption option) async* {
    List<Submission> submissions = await redditRepository.subredditsSubmissions(
      title: event.title,
      option: option,
      group: groupLoaded++,
    );

    yield Submissions(
      submissions: submissions,
    );
  }
}

class SubmissionsHotBloc extends SubmissionsBloc {
  SubmissionsHotBloc({
    redditRepository,
  }) : super(
    redditRepository: redditRepository,
  );
}

class SubmissionsNewestBloc extends SubmissionsBloc {
  SubmissionsNewestBloc({
    redditRepository,
  }) : super(
    redditRepository: redditRepository,
  );
}

class SubmissionsControversialBloc extends SubmissionsBloc {
  SubmissionsControversialBloc({
    redditRepository,
  }) : super(
    redditRepository: redditRepository,
  );
}

class SubmissionsTopBloc extends SubmissionsBloc {
  SubmissionsTopBloc({
    redditRepository,
  }) : super(
    redditRepository: redditRepository,
  );
}
