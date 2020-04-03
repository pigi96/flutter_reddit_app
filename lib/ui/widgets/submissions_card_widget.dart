import 'package:cached_network_image/cached_network_image.dart';
import 'package:draw/draw.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redditapp/blocs/submissions/bloc_submissions.dart';
import 'package:redditapp/blocs/submissions/submissions_bloc.dart';
import 'package:redditapp/blocs/submissions/submissions_state.dart';
import 'package:redditapp/blocs/submissions_info/submissions_info_bloc.dart';
import 'package:redditapp/blocs/submissions_info/submissions_info_event.dart';
import 'package:redditapp/blocs/submissions_info/submissions_info_state.dart';
import 'package:redditapp/helpers/stuff.dart';
import 'package:redditapp/helpers/time_converter.dart';
import 'package:redditapp/repositories/reddit_repository.dart';
import 'package:redditapp/ui/pages/submissions/submissions_page_controller.dart';

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
  Widget build(BuildContext context) {
    final SubmissionsInfoBloc bloc = SubmissionsInfoBloc(
      redditRepository: RepositoryProvider.of<RedditRepository>(context),
      submission: widget.submission,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: BlocBuilder<SubmissionsInfoBloc, SubmissionsInfoState>(
        bloc: bloc,
        builder: (context, submissionInfo) {
          print("REBUILD");
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                        "${submissionInfo.submission.author} - ${getTimeDiff(submissionInfo.submission.createdUtc)}"),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(widget.submission.title),
                SizedBox(
                  height: 5.0,
                ),
                CachedNetworkImage(
                  imageUrl: checkForUrl(submissionInfo.submission.preview),
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  widget.submission.selftext,
                  maxLines: 10,
                  overflow: TextOverflow.fade,
                ),
                SizedBox(
                  height: 5.0,
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
                        Text("${submissionInfo.submission.upvotes}/${submissionInfo.submission.downvotes}"),
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
                          Text("${submissionInfo.submission.numComments} Comments"),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
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