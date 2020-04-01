import 'package:draw/draw.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SubmissionsState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialSubmissionsState extends SubmissionsState {}
class SubmissionsLoaded extends SubmissionsState {
  final List<Submission> submissions;

  SubmissionsLoaded({
    @required this.submissions,
  });

  @override
  List<Object> get props => [submissions];
}
