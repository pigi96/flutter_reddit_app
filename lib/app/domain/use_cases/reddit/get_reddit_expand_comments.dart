import 'package:dartz/dartz.dart';
import 'package:draw/draw.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/app/data/models/reddit.dart';
import 'package:redditapp/app/domain/repositories/reddit_repository.dart';
import 'package:redditapp/core/errors/failures.dart';
import 'package:redditapp/core/use_cases/use_case.dart';

class GetRedditExpandComments implements UseCase<void, Params> {
  final RedditRepository redditRepository;

  GetRedditExpandComments(this.redditRepository);

  @override
  Future<Either<Failure, dynamic>> call(Params params) async {
    return redditRepository.expandComments(moreComments: params.moreComments);
  }
}

class Params extends Equatable {
  final MoreComments moreComments;

  Params({@required this.moreComments});

  @override
  List<Object> get props => [];
}