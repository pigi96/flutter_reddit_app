import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/app/presentation/bloc/comments_info/bloc_comments_info.dart';
import 'package:redditapp/helpers/time_converter.dart';
import 'package:redditapp/injection_container.dart';

class CommentsTree extends StatefulWidget {
  final comment;

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
    for (var oneTree in buildCommentsTree) {
      if (oneTree is Comment) {
        commentsList.add(BlocBuilder<CommentsInfoBloc, CommentsInfoState>(
          bloc: sl.get<CommentsInfoBloc>(param1: oneTree),
          builder: (context, commentState) {
            final comment = commentState.comment;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Padding(
                  padding:
                      EdgeInsets.fromLTRB(15.0 * oneTree.depth, 10.0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        "${comment.author} - ${getTimeDiff(comment.createdUtc)}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11.0,
                        ),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text("${comment.body}"),
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_upward),
                            onPressed: () {
                              //bloc.add(UpVoteComment());
                            },
                          ),
                          Text("${comment.upvotes}"),
                          IconButton(
                            icon: Icon(Icons.arrow_downward),
                            onPressed: () {
                              //bloc.add(DownVoteComment());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
      } else if (oneTree is MoreComments) {
        final bloc = sl.get<CommentsInfoBloc>(param2: oneTree);
        commentsList.add(
          BlocBuilder<CommentsInfoBloc, CommentsInfoState>(
            bloc: bloc,
            builder: (context, moreCommentsState) {
              print(moreCommentsState);
              return FlatButton(
                child: Text("${oneTree.count} more replies"),
                onPressed: () {
                  bloc.add(LoadMoreComments());
                },
              );
            },
          ),
        );
      }
    }
  }

  Widget build(BuildContext context) {
    return Column(
      children: commentsList,
    );
  }
}

var listy;
List callToTreeList(var comment) {
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
