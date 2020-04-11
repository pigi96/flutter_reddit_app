import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redditapp/app/presentation/pages/comments/comments_tree.dart';

class CommentsWidget extends StatefulWidget {
  final comment;

  CommentsWidget({
    this.comment,
  });

  @override
  _CommentsWidgetState createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget> {
  @override
  Widget build(BuildContext context) {
    //allInOneTest(widget.comment);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Card(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Padding(
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
              child: CommentsTree(widget.comment),
              ),
            ),
    );
  }
}

Icon upVoted(VoteState voteState) {
  Color color = Colors.black12;
  if (voteState == VoteState.upvoted) {
    color = Colors.orange;
  }

  return Icon(
    Icons.arrow_upward,
    color: color,
  );
}

Icon downVoted(VoteState voteState) {
  Color color = Colors.black12;
  if (voteState == VoteState.downvoted) {
    color = Colors.orange;
  }

  return Icon(
    Icons.arrow_downward,
    color: color,
  );
}

void allInOneTest(Comment comment) {
  if (comment.replies != null) {
    for(int i = 0; i < comment.replies.toList().length; i++) {
      print((comment.replies.toList()[i] as Comment));
    }
  }
}