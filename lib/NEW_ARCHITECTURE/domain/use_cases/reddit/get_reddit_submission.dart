import 'package:dartz/dartz.dart';
import 'package:draw/draw.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/NEW_ARCHITECTURE/data/models/reddit.dart';
import 'package:redditapp/NEW_ARCHITECTURE/domain/repositories/reddit_repository.dart';
import 'package:redditapp/core/errors/failures.dart';
import 'package:redditapp/core/use_cases/use_case.dart';

class GetRedditSubmission implements UseCase<Submission, Params> {
  final RedditRepository redditRepository;

  GetRedditSubmission(this.redditRepository);

  @override
  Future<Either<Failure, Submission>> call(Params params) async {
    return redditRepository.submission(id: params.id);
  }
}

class Params extends Equatable {
  final String id;

  Params({@required this.id});

  @override
  List<Object> get props => [];
}