import 'package:draw/draw.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class CommentsState extends Equatable {
  final Submission submission;

  CommentsState({
    @required this.submission,
  });

  @override
  List<Object> get props => [];
}

class InitialCommentsState extends CommentsState {}

class LoadSubmission extends CommentsState {
  LoadSubmission({
    submission,
  }) : super(submission: submission);
}
