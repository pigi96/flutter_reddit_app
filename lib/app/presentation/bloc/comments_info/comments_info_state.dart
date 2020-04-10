import 'package:meta/meta.dart';
import 'package:draw/draw.dart';

abstract class CommentsInfoState {
  final Comment comment;
  CommentsInfoState(this.comment);
}

class InitialCommentsInfoState extends CommentsInfoState {
  InitialCommentsInfoState(comment):super(comment);
}

class CommentInfo extends CommentsInfoState {
  CommentInfo(comment):super(comment);
}