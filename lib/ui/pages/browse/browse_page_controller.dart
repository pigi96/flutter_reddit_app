import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redditapp/blocs/browse/bloc_browse.dart';
import 'package:redditapp/ui/pages/helpers/page_helper.dart';

import 'browse_page.dart';


class BrowsePageController extends StatefulWidget {
  @override
  _BrowsePageControllerState createState() => _BrowsePageControllerState();
}

class _BrowsePageControllerState extends State<BrowsePageController> {
  Pages _pages;

  @override
  void initState() {
    super.initState();
    _pages = Pages();

    _pages.add(
      widget: BrowsePage(
        dataEvent: GetPopularSubreddits(),
      ),
      tab: Tab(
        icon: Icon(Icons.add),
      ),
    );
    _pages.add(
      widget: BrowsePage(
        dataEvent: GetNewestSubreddits(),
      ),
      tab: Tab(
        icon: Icon(Icons.delete),
      ),
    );
    _pages.add(
      widget: BrowsePage(
        dataEvent: GetGoldSubreddits(),
      ),
      tab: Tab(
        icon: Icon(Icons.search),
      ),
    );
    _pages.add(
      widget: BrowsePage(
        dataEvent: GetDefaultsSubreddits(),
      ),
      tab: Tab(
        icon: Icon(Icons.print),
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
