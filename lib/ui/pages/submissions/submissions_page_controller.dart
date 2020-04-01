import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redditapp/blocs/submissions/submissions_event.dart';

import 'package:redditapp/ui/pages/helpers/page_helper.dart';
import 'package:redditapp/ui/pages/submissions/submissions_page.dart';


class SubmissionsPageController extends StatefulWidget {
  final String title;

  SubmissionsPageController({
    @required this.title,
  });

  @override
  _SubmissionsPageControllerState createState() => _SubmissionsPageControllerState();
}

class _SubmissionsPageControllerState extends State<SubmissionsPageController> {
  Pages _pages;

  @override
  void initState() {
    super.initState();
    _pages = Pages();

    _pages.add(
      widget: SubmissionsPage(
        dataEvent: GetHotSubmissions(
          title: widget.title,
        ),
      ),
      tab: Tab(
        icon: Icon(Icons.directions_bike),
      ),
    );
    _pages.add(
      widget: SubmissionsPage(
        dataEvent: GetNewestSubmissions(
          title: widget.title,
        ),
      ),
      tab: Tab(
        icon: Icon(Icons.directions_bus),
      ),
    );
    _pages.add(
      widget: SubmissionsPage(
        dataEvent: GetControversialSubmissions(
          title: widget.title,
        ),
      ),
      tab: Tab(
        icon: Icon(Icons.directions_boat),
      ),
    );
    _pages.add(
      widget: SubmissionsPage(
        dataEvent: GetTopSubmissions(
          title: widget.title,
        ),
      ),
      tab: Tab(
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _pages.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                tabs: _pages.tabs,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: _pages.widgets,
        ),
      ),
    );
  }
}
