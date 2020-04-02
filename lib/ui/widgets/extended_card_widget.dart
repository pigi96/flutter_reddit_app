import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redditapp/ui/pages/submissions/submissions_page_controller.dart';

class ExtendedCardWidget extends StatefulWidget {
  final int index;
  final String title;
  final String subtitle;
  final String info;
  final String imageUrl;

  ExtendedCardWidget({
    @required this.index,
    @required this.title,
    @required this.info,
    @required this.subtitle,
    @required this.imageUrl,
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
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: CachedNetworkImage(
            imageUrl: widget.imageUrl,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        title: Text(widget.title),
        subtitle: Text(widget.subtitle),
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
              child: Text(widget.info,
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
                onPressed: () {},
                child: Column(
                  children: <Widget>[
                    Icon(Icons.star),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('Subscribe'),
                  ],
                ),
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                onPressed: () {
                  Route route = MaterialPageRoute(
                    builder: (context) => SubmissionsPageController(
                      title: widget.title,
                    ),
                  );
                  Navigator.push(context, route);
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.open_in_browser),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('Open In App'),
                  ],
                ),
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                onPressed: () {},
                child: Column(
                  children: <Widget>[
                    Icon(Icons.add_to_home_screen),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('Open In Webpage'),
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
