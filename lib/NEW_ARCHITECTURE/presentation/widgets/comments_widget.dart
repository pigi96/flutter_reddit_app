import 'package:cached_network_image/cached_network_image.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/NEW_ARCHITECTURE/domain/repositories/reddit_repository.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/submissions_info/submissions_info_bloc.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/submissions_info/submissions_info_event.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/submissions_info/submissions_info_state.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/pages/comments/comments_page.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/pages/submissions/submissions_page.dart';
import 'package:redditapp/helpers/stuff.dart';
import 'package:redditapp/helpers/time_converter.dart';

class CommentsWidget extends StatefulWidget {
  final Comment comment;

  CommentsWidget({
    this.comment,
  });

  @override
  _CommentsWidgetState createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  SubmissionsInfoBloc bloc;
  @override
  Widget build(BuildContext context) {
      /*bloc = SubmissionsInfoBloc(
      submission: widget.submission,
    );*/

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Card(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
                      child: Text(
                          "${widget.comment.body} ",
                      style: TextStyle(
                        color: Colors.blueAccent,
                      ),),
                    ),
                  ],
                ),

                  ],
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
