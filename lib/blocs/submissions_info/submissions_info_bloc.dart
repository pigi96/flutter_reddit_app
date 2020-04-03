import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/blocs/submissions_info/bloc_submissions_info.dart';
import 'package:redditapp/repositories/reddit_repository.dart';

class SubmissionsInfoBloc extends Bloc<SubmissionsInfoEvent, SubmissionsInfoState> {
  RedditRepository redditRepository;
  Submission submission;

  SubmissionsInfoBloc({
    @required this.redditRepository,
    @required this.submission,
  });

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
    print(submission.upvotes);
    print(submission.downvotes);
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

    Submission newSubmission = await redditRepository.submissions(
        id: submission.id
    );

    print(newSubmission.upvotes);
    print(newSubmission.downvotes);

    yield SubmissionInfo(newSubmission);
  }
}