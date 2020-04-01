import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redditapp/blocs/browse/bloc_browse.dart';

class BrowsePage extends StatefulWidget {
  final BrowseEvent dataEvent;

  BrowsePage({
    @required this.dataEvent,
  });

  @override
  _BrowsePageState createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  @override
  Widget build(BuildContext context) {
    if (widget.dataEvent is GetPopularSubreddits) {
      return Container(
        color: Colors.amber,
      );
    } else if (widget.dataEvent is GetNewestSubreddits) {
      return Container(
        color: Colors.red,
      );
    } else if (widget.dataEvent is GetGoldSubreddits) {
      return Container(
        color: Colors.redAccent,
      );
    } else if (widget.dataEvent is GetDefaultsSubreddits) {
      return Container(
        color: Colors.cyanAccent,
      );
    }

    return Container(
      color: Colors.amber,
    );
  }
}