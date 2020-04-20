import 'package:dartz/dartz.dart';
import 'package:draw/draw.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/app/domain/repositories/reddit_repository.dart';
import 'package:redditapp/app/domain/repositories/storage_repository.dart';
import 'package:redditapp/core/errors/failures.dart';
import 'package:redditapp/core/use_cases/use_case.dart';

class CleanStorage implements UseCase<Submission, Params> {
  final StorageRepository storageRepository;

  CleanStorage(this.redditRepository);

  @override

  Future<Either<Failure, Submission>> call(Params params) async {
    return redditRepository.comments(submission: params.submission);
  }
}

class Params extends Equatable {
  final Submission submission;

  Params({@required this.submission});

  @override
  List<Object> get props => [];
}