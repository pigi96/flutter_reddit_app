import 'package:dartz/dartz.dart';
import 'package:draw/draw.dart';
import 'package:equatable/equatable.dart';
import 'package:redditapp/app/data/models/reddit.dart';
import 'package:redditapp/app/domain/repositories/reddit_repository.dart';
import 'package:redditapp/app/presentation/bloc/submissions/submissions_state.dart';
import 'package:redditapp/core/errors/failures.dart';
import 'package:redditapp/core/use_cases/use_case.dart';

class GetRedditSubredditsSubmissions implements UseCase<List<Submission>, Params> {
  final RedditRepository redditRepository;

  GetRedditSubredditsSubmissions(this.redditRepository);

  @override
  Future<Either<Failure, List<Submission>>> call(Params params) async {
    return redditRepository.subredditsSubmissions(title: params.title, option: params.option, after: params.after);
  }
}

class Params extends Equatable {
  final String title;
  final SubmissionOption option;
  final String after;

  Params({this.title, this.option, this.after});

  @override
  List<Object> get props => [];
}