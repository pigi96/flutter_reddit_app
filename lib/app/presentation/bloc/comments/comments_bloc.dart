import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:redditapp/app/domain/use_cases/reddit/get_reddit_submission_comments.dart';
import './bloc_comments.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final GetRedditSubmissionComments getRedditSubmissionComments;

  CommentsBloc(this.getRedditSubmissionComments) : super(InitialCommentsState());

  @override
  Stream<CommentsState> mapEventToState(
    CommentsEvent event,
  ) async* {
    if (event is GetComments) {
      yield* _mapGetCommentsToState(event);
    } else {
      yield LoadingComments();
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
