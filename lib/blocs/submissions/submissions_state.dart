import 'package:draw/draw.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SubmissionsState extends Equatable {
  final List<Submission> submissions;

  SubmissionsState({
    @required this.submissions,
  });

  @override
  List<Object> get props => [submissions];
}

class InitialSubmissionsState extends SubmissionsState {}
class Submissions extends SubmissionsState {
  Submissions({
    submissions,
  }) : super(
    submissions: submissions,
  );
}
