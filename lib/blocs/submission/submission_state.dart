import 'package:draw/draw.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SubmissionState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialSubmissionState extends SubmissionState {}
class SubmissionsLoaded extends SubmissionState {
  final List<Submission> submissions;

  SubmissionsLoaded({
    @required this.submissions,
  });

  @override
  List<Object> get props => [submissions];
}
