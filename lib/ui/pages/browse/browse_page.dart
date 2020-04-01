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
    return Container(
      color: Colors.amber,
    );
  }
}