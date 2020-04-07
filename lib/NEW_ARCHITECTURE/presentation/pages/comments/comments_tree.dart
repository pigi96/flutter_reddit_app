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
      var buildCommentsTree = callToTreeList(widget.comment);
      for (Comment oneTree in buildCommentsTree) {
        commentsList.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(15.0*oneTree.depth, 10.0, 0, 0),
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
          ),
        ));
    }
  }

  Widget build(BuildContext context) {
    return Column(
      children: commentsList,
    );
  }
}

var listy;
List callToTreeList(Comment comment) {
  listy = List<dynamic>();
  var test = List<dynamic>();
  test.add(comment);
  toTreeList(test);
  return listy;
}

void toTreeList(var comments) {
  for (var comment in comments) {
    listy.add(comment);
    if ((comment is! MoreComments) && (comment.replies != null)) {
      toTreeList((comment.replies.comments));
    }
  }
}