import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/NEW_ARCHITECTURE/domain/repositories/reddit_repository.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/submissions_info/submissions_info_event.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/submissions_info/submissions_info_state.dart';

class SubmissionsInfoBloc extends Bloc<SubmissionsInfoEvent, SubmissionsInfoState> {
  RedditRepository redditRepository;
  Submission submission;

  SubmissionsInfoBloc({
    @required this.redditRepository,
    @required this.submission,
  }) : assert(redditRepository != null);

  @override
  SubmissionsInfoState get initialState => InitialSubmissionsInfoState(submission);

  @override
  Stream<SubmissionsInfoState> mapEventToState(
      SubmissionsInfoEvent event,
      ) async* {
    if (event is UpVoteSubmission) {
      yield* _mapVoteSubmissionState(event);
    } else if (event is DownVoteSubmission) {
      yield* _mapVoteSubmissionState(event);
    }
  }

  Stream<SubmissionsInfoState> _mapVoteSubmissionState(SubmissionsInfoEvent event) async* {
    var response;
    if (event is UpVoteSubmission && (submission.vote == VoteState.none ||
                                      submission.vote == VoteState.downvoted)) {
      response = submission.upvote(waitForResponse: true);
    } else if (event is DownVoteSubmission && (submission.vote == VoteState.none ||
                                               submission.vote == VoteState.upvoted)) {
      response = submission.downvote(waitForResponse: true);
    } else {
      response = submission.clearVote(waitForResponse: true);
    }

    await response;

    yield SubmissionInfo(submission);
  }
}