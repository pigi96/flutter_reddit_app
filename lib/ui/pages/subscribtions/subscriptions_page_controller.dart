import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redditapp/blocs/subscriptions/bloc_subscriptions.dart';
import 'package:redditapp/ui/pages/helpers/page_helper.dart';
import 'package:redditapp/ui/pages/subscribtions/subscriptions_page.dart';

class SubscriptionsPageController extends StatefulWidget {
  @override
  _SubscriptionsPageControllerState createState() => _SubscriptionsPageControllerState();
}

class _SubscriptionsPageControllerState extends State<SubscriptionsPageController> {
  Pages _pages;

  @override
  void initState() {
    super.initState();
    _pages = Pages();

    _pages.add(
      widget: SubscriptionsPage(
        dataEvent: GetDefaultSubscriptions(),
      ),
      tab: Tab(
        icon: Icon(Icons.directions_bike),
      ),
    );
    _pages.add(
      widget: SubscriptionsPage(
        dataEvent: GetContributorSubscriptions(),
      ),
      tab: Tab(
        icon: Icon(Icons.directions_bus),
      ),
    );
    _pages.add(
      widget: SubscriptionsPage(
        dataEvent: GetModeratorSubscriptions(),
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
