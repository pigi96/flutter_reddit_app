import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/app/data/models/reddit.dart';
import 'package:redditapp/app/domain/repositories/reddit_repository.dart';
import 'package:redditapp/app/domain/use_cases/reddit/post_reddit_comment_vote.dart';
import './bloc_comments_info.dart';
import 'package:draw/draw.dart';

class CommentsInfoBloc extends Bloc<CommentsInfoEvent, CommentsInfoState> {
  final RedditRepository redditRepository;
  final PostRedditCommentVote postRedditCommentVote;
  Comment comment;

  CommentsInfoBloc({
    @required this.redditRepository,
    @required this.postRedditCommentVote,
    @required this.comment,
  });

  @override
  CommentsInfoState get initialState => InitialCommentsInfoState(comment);

  @override
  Stream<CommentsInfoState> mapEventToState(
    CommentsInfoEvent event,
  ) async* {
    if (event is UpVoteComment) {
      yield* _mapVoteSubmissionState(event);
    } else if (event is DownVoteComment) {
      yield* _mapVoteSubmissionState(event);
    }
  }

  Stream<CommentsInfoState> _mapVoteSubmissionState(
      CommentsInfoEvent event) async* {
    var response;
    if (event is UpVoteComment &&
        (comment.vote == VoteState.none ||
            comment.vote == VoteState.downvoted)) {
      response = postRedditCommentVote(Params(
        comment: comment,
        option: VoteOption.up,
      ));
    } else if (event is DownVoteComment &&
        (comment.vote == VoteState.none || comment.vote == VoteState.upvoted)) {
      response = postRedditCommentVote(Params(
        comment: comment,
        option: VoteOption.down,
      ));
    } else {
      response = postRedditCommentVote(Params(
        comment: comment,
        option: VoteOption.clear,
      ));
    }

    await response;

    yield response.fold(
          (failure) => null,
          (commentUpdated) {
        return CommentInfo(comment);
      },
    );
  }
}
