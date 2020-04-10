import 'package:draw/draw.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class CommentsEvent extends Equatable {
  final Submission submission;

  CommentsEvent({
    @required this.submission,
  });

  @override
  List<Object> get props => [submission];
}

class GetComments extends CommentsEvent {
  GetComments({submission}) : super(submission: submission);
}
