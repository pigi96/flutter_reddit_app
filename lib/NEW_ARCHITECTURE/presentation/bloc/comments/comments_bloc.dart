import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:redditapp/NEW_ARCHITECTURE/domain/use_cases/reddit/get_reddit_submission_comments.dart';
import './bloc_comments.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final GetRedditSubmissionComments getRedditSubmissionComments;

  CommentsBloc(this.getRedditSubmissionComments);

  @override
  CommentsState get initialState => InitialCommentsState();

  @override
  Stream<CommentsState> mapEventToState(
    CommentsEvent event,
  ) async* {
    if (event is GetComments) {
      yield* _mapGetCommentsToState(event);
    }
  }

  Stream<CommentsState> _mapGetCommentsToState(GetComments event) async* {
    final getSubmissions = await getRedditSubmissionComments(Params(submission: event.submission));
    yield getSubmissions.fold((failure) => null,
        (submissionReceived) {
          return LoadSubmission(
            submission: submissionReceived,
          );
        },
    );
  }
}
