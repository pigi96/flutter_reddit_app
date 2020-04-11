import 'package:cached_network_image/cached_network_image.dart';
import 'package:draw/draw.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redditapp/app/presentation/pages/submissions/submissions_page.dart';


class ExtendedCardWidget extends StatefulWidget {
  final Subreddit subreddit;

  ExtendedCardWidget({
    @required this.subreddit,
  });

  @override
  _ExtendedCardWidgetState createState() => _ExtendedCardWidgetState();
}

class _ExtendedCardWidgetState extends State<ExtendedCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ExpansionTileCard(
        leading: ClipOval(
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: CachedNetworkImage(
              imageUrl: widget.subreddit.iconImage.toString(),
              placeholder: (context, url) => Icon(Icons.child_care, size: 35.0,),
              errorWidget: (context, url, error) => Icon(Icons.child_care, size: 35.0,),
            ),
          ),
        ),
        title: Text(widget.subreddit.title),
        subtitle: Text("Tap to load more"),
        children: <Widget>[
          Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text("${widget.subreddit.data["public_description"]}",
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(fontSize: 16),
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            buttonHeight: 52.0,
            buttonMinWidth: 90.0,
            children: <Widget>[
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                onPressed: () {
                  Route route = MaterialPageRoute(
                    builder: (context) => SubmissionsPage(
                      subreddit: widget.subreddit,
                    ),
                  );
                  Navigator.push(context, route);
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.add),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('Open In App'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
