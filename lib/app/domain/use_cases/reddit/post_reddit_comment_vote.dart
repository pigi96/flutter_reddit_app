import 'package:dartz/dartz.dart';
import 'package:draw/draw.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/app/data/models/reddit.dart';
import 'package:redditapp/app/domain/repositories/reddit_repository.dart';
import 'package:redditapp/core/errors/failures.dart';
import 'package:redditapp/core/use_cases/use_case.dart';

class PostRedditCommentVote implements UseCase<Comment, Params> {
  final RedditRepository redditRepository;

  PostRedditCommentVote(this.redditRepository);

  @override
  Future<Either<Failure, Comment>> call(Params params) async {
    return redditRepository.commentVote(comment: params.comment, option: params.option);
  }
}

class Params extends Equatable {
  final Comment comment;
  final VoteOption option;

  Params({@required this.option,
  @required this.comment});

  @override
  List<Object> get props => [];
}