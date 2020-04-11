import 'package:meta/meta.dart';
import 'package:draw/draw.dart';

abstract class CommentsInfoState {
  final Comment comment;
  List<dynamic> moreComments;

  CommentsInfoState(this.comment, {
    this.moreComments,
  });
}

class InitialCommentsInfoState extends CommentsInfoState {
  InitialCommentsInfoState(comment):super(comment);
}

class CommentInfo extends CommentsInfoState {
  CommentInfo(comment):super(comment);
}

class CommentsExpanded extends CommentsInfoState {
  CommentsExpanded({
    moreComments,
  }):super(null, moreComments: moreComments);
}