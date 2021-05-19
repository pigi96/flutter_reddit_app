import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/app/data/models/reddit.dart';
import 'package:redditapp/app/domain/repositories/reddit_repository.dart';
import 'package:redditapp/app/domain/use_cases/reddit/get_reddit_expand_comments.dart' as exp;
import 'package:redditapp/app/domain/use_cases/reddit/post_reddit_comment_vote.dart' as vote;
import './bloc_comments_info.dart';
import 'package:draw/draw.dart';

class CommentsInfoBloc extends Bloc<CommentsInfoEvent, CommentsInfoState> {
  final RedditRepository redditRepository;
  final vote.PostRedditCommentVote postRedditCommentVote;
  final exp.GetRedditExpandComments getRedditExpandComments;
  var comment;
  var moreComments;

  CommentsInfoBloc({
    @required this.redditRepository,
    @required this.postRedditCommentVote,
    @required this.getRedditExpandComments,
    this.comment,
    this.moreComments,
  }) : super(InitialCommentsInfoState(comment));

  @override
  Stream<CommentsInfoState> mapEventToState(
    CommentsInfoEvent event,
  ) async* {
    if (event is UpVoteComment) {
      yield* _mapVoteSubmissionState(event);
    } else if (event is DownVoteComment) {
      yield* _mapVoteSubmissionState(event);
    } else if (event is LoadMoreComments) {
      yield* _mapLoadMoreCommentsToState();
    }
  }

  Stream<CommentsInfoState> _mapVoteSubmissionState(
      CommentsInfoEvent event) async* {
    var response;
    if (event is UpVoteComment &&
        (comment.vote == VoteState.none ||
            comment.vote == VoteState.downvoted)) {
      response = postRedditCommentVote(vote.Params(
        comment: comment,
        option: VoteOption.up,
      ));
    } else if (event is DownVoteComment &&
        (comment.vote == VoteState.none || comment.vote == VoteState.upvoted)) {
      response = postRedditCommentVote(vote.Params(
        comment: comment,
        option: VoteOption.down,
      ));
    } else {
      response = postRedditCommentVote(vote.Params(
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

  Stream<CommentsInfoState> _mapLoadMoreCommentsToState() async* {
    var response = await getRedditExpandComments(exp.Params(moreComments: moreComments));
    yield response.fold(
        (failure) => null,
        (status) {
          return CommentsExpanded(
            moreComments: status,
          );
        },
    );
  }
}
