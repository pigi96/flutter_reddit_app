import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/app/domain/repositories/reddit_repository.dart';
import 'package:redditapp/app/presentation/bloc/subscriptions/subscriptions_bloc.dart';
import 'package:redditapp/app/presentation/bloc/subscriptions/subscriptions_event.dart';
import 'package:redditapp/app/presentation/pages/helpers/page_helper.dart';
import 'package:redditapp/app/presentation/pages/subscribtions/subscriptions_page.dart';

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
        body: BlocProvider<SubscriptionsBloc>(
          create: (context) => SubscriptionsBloc(
            redditRepository: RepositoryProvider.of<RedditRepository>(context),
          ),
          child: TabBarView(
            children: _pages.widgets,
          ),
        ),
      ),
    );
  }
}
