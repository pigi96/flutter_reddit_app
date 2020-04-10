import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/app/data/models/reddit.dart';
import 'package:redditapp/app/domain/repositories/reddit_repository.dart';
import 'package:redditapp/app/domain/use_cases/reddit/post_reddit_submission_vote.dart';
import 'package:redditapp/app/presentation/bloc/submissions_info/submissions_info_event.dart';
import 'package:redditapp/app/presentation/bloc/submissions_info/submissions_info_state.dart';

class SubmissionsInfoBloc extends Bloc<SubmissionsInfoEvent, SubmissionsInfoState> {
  RedditRepository redditRepository;
  PostRedditSubmissionVote postRedditSubmissionVote;
  Submission submission;

  SubmissionsInfoBloc({
    @required this.redditRepository,
    @required this.submission,
    @required this.postRedditSubmissionVote,
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
    if (event is UpVoteSubmission && (submission.vote == VoteState.none ||
                                      submission.vote == VoteState.downvoted)) {
      response = await postRedditSubmissionVote(Params(submission: submission, option: VoteOption.up));
    } else if (event is DownVoteSubmission && (submission.vote == VoteState.none ||
                                               submission.vote == VoteState.upvoted)) {
      response = await postRedditSubmissionVote(Params(submission: submission, option: VoteOption.down));
    } else {
      response = await postRedditSubmissionVote(Params(submission: submission, option: VoteOption.clear));
    }

    await response;

    yield response.fold(
        (failure) => null,
        (submissionUpdate) {
          return SubmissionInfo(submission);
        }
    );
  }
}