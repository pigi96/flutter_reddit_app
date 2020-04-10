import 'package:dartz/dartz.dart';
import 'package:draw/draw.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/app/data/models/reddit.dart';
import 'package:redditapp/app/domain/repositories/reddit_repository.dart';
import 'package:redditapp/core/errors/failures.dart';
import 'package:redditapp/core/use_cases/use_case.dart';

class PostRedditSubmissionVote implements UseCase<Submission, Params> {
  final RedditRepository redditRepository;

  PostRedditSubmissionVote(this.redditRepository);

  @override
  Future<Either<Failure, Submission>> call(Params params) async {
    return redditRepository.submissionVote(submission: params.submission, option: params.option);
  }
}

class Params extends Equatable {
  final Submission submission;
  final VoteOption option;

  Params({@required this.option,
  @required this.submission});

  @override
  List<Object> get props => [];
}