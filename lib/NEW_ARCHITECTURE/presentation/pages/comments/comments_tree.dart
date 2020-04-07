import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redditapp/helpers/time_converter.dart';

class CommentsTree extends StatefulWidget {
  final Comment comment;

  CommentsTree(this.comment);

  @override
  _CommentsTreeState createState() => _CommentsTreeState();
}

class _CommentsTreeState extends State<CommentsTree> {
  List<Widget> commentsList = List<Widget>();

  @override
  initState() {
    super.initState();
    commentsList.add(Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text("${widget.comment.author} - ${getTimeDiff(widget.comment.createdUtc)}"),
          Text("${widget.comment.body}"),
        ],
      ),
    ));
    if (widget.comment.replies != null) {
      var buildCommentsTree = widget.comment.replies.toList();
      for (Comment oneTree in buildCommentsTree) {
        commentsList.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text("${oneTree.author} - ${getTimeDiff(oneTree.createdUtc)}",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10.0,
                ),),
                SizedBox(height: 5.0,),
                Text("${oneTree.body}"),
              ],
            ),
          ),
        ));
      }
    }
  }

  Widget build(BuildContext context) {
    return Column(
      children: commentsList,
    );
  }
}
