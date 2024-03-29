import 'package:cached_network_image/cached_network_image.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/app/presentation/bloc/submissions_info/bloc_submissions_info.dart';
import 'package:redditapp/app/presentation/bloc/submissions_info/submissions_info_bloc.dart';
import 'package:redditapp/app/presentation/bloc/submissions_info/submissions_info_event.dart';
import 'package:redditapp/app/presentation/bloc/submissions_info/submissions_info_state.dart';
import 'package:redditapp/app/presentation/pages/comments/comments_page.dart';
import 'package:redditapp/app/presentation/widgets/fullscreen_pic_widget.dart';
import 'package:redditapp/helpers/stuff.dart';
import 'package:redditapp/helpers/time_converter.dart';
import 'package:redditapp/injection_container.dart';

class SubmissionsCardWidget extends StatefulWidget {
  final Submission submission;

  SubmissionsCardWidget({
    this.submission,
  });

  @override
  _SubmissionsCardWidgetState createState() => _SubmissionsCardWidgetState();
}

class _SubmissionsCardWidgetState extends State<SubmissionsCardWidget> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  SubmissionsInfoBloc bloc;
  @override
  Widget build(BuildContext context) {
    bloc = sl.get<SubmissionsInfoBloc>(param1: widget.submission);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: BlocBuilder<SubmissionsInfoBloc, SubmissionsInfoState>(
        bloc: bloc,
        builder: (context, submissionInfo) {
          return Card(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
                      child: Text(
                          "u/${submissionInfo.submission.author} - ${getTimeDiff(submissionInfo.submission.createdUtc)}",
                      style: TextStyle(
                        color: Colors.blueAccent,
                      ),),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0, 0),
                  child: Text(widget.submission.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),),
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  child: CachedNetworkImage(
                    imageUrl: checkForUrl(submissionInfo.submission.preview),
                    //fit: BoxFit.fitWidth,
                    //width: double.infinity,
                    alignment: Alignment.center,
                    height: placeholderHeight(context, submissionInfo),
                    width: double.infinity,
                  ),
                  onTap: () {
                    Route route = CupertinoPageRoute(
                      builder: (context) => FullscreenPicWidget(
                        submissionInfo,
                      ),
                    );
                    Navigator.push(context, route);
                  },
                ),
                selftext(widget.submission),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: upVoted(submissionInfo.submission.vote),
                          onPressed: () {
                            bloc.add(UpVoteSubmission());
                          },
                        ),
                        Text(
                            "${submissionInfo.submission.upvotes}"),
                        IconButton(
                          icon: downVoted(submissionInfo.submission.vote),
                          onPressed: () {
                            bloc.add(DownVoteSubmission());
                          },
                        ),
                      ],
                    ),
                    FlatButton(
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.comment),
                          Text(
                              "${submissionInfo.submission.numComments} Comments"),
                        ],
                      ),
                      onPressed: () {
                        Route route = MaterialPageRoute(
                          builder: (context) => CommentsPage(
                            submission: submissionInfo.submission,
                          ),
                        );
                        Navigator.push(context, route);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10.0,),
              ],
            ),
          );
        },
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

double placeholderHeight(BuildContext context, SubmissionsInfoState submissionInfo) {
  if (submissionInfo.submission.preview.length == 0) return 0.0;
  
  var height = submissionInfo.submission.preview[0].source.height;
  var width = submissionInfo.submission.preview[0].source.width;
  var per = MediaQuery.of(context).size.width / width;
  
  return height * per;
}

Widget selftext(Submission submission) {
  if (submission.selftext.length == 0) return SizedBox();

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      submission.selftext,
      maxLines: 10,
      overflow: TextOverflow.fade,
    ),
  );
}