import 'package:cached_network_image/cached_network_image.dart';
import 'package:draw/draw.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redditapp/blocs/submissions/submissions_state.dart';
import 'package:redditapp/helpers/stuff.dart';
import 'package:redditapp/helpers/time_converter.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                    "${widget.submission.author} - ${getTimeDiff(widget.submission.createdUtc)}"),
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
              imageUrl: checkForUrl(widget.submission.preview),
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
                      icon: Icon(Icons.arrow_upward),
                      onPressed: () {},
                    ),
                    Text("${widget.submission.upvotes}"),
                    IconButton(
                      icon: Icon(Icons.arrow_downward),
                      onPressed: () {},
                    ),
                  ],
                ),
                FlatButton(
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.comment),
                      Text("${widget.submission.numComments} Comments"),
                    ],
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
