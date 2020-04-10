import 'package:cached_network_image/cached_network_image.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redditapp/helpers/text_editor.dart';

class SubmissionsPageCover extends StatefulWidget {
  final Subreddit subreddit;

  SubmissionsPageCover(this.subreddit);

  @override
  _SubmissionsPageCoverState createState() => _SubmissionsPageCoverState();
}

class _SubmissionsPageCoverState extends State<SubmissionsPageCover> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Column(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: widget.subreddit.mobileHeaderImage.toString(),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                        child: Text("Members: ${(subscribersCount(widget.subreddit.data["subscribers"]))}"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    widget.subreddit.path,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                    ),
                    color: Colors.blueAccent,
                    child: Text(
                      "Subscribe",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(height: 10.0,),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(widget.subreddit.data["public_description"]),
                  ),
                ],
              ),
              Positioned(
                top: 80.0,
                child: Container(
                  padding: EdgeInsets.all(3.0),
                  decoration: new BoxDecoration(
                    color: const Color(0xFFFFFFFF), // border color
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 36.0,
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: widget.subreddit.iconImage.toString(),
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
