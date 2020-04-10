import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:redditapp/app/presentation/bloc/submissions/submissions_event.dart';

abstract class SubmissionsState {
  final List<Submission> submissions;
  final SubmissionsEvent submissionsEvent;

  SubmissionsState({
    @required this.submissions,
    @required this.submissionsEvent,
  });
}

class InitialSubmissionsState extends SubmissionsState {}

class LoadingSubmissions extends SubmissionsState {}

class Submissions extends SubmissionsState {
  Submissions({
    submissions,
    submissionsEvent,
  }) : super(
    submissions: submissions,
    submissionsEvent: submissionsEvent,
  );
}
