import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/blocs/browse/bloc_browse.dart';
import 'package:redditapp/reddit/reddit.dart';
import 'package:redditapp/repositories/reddit_repository.dart';
import 'package:redditapp/ui/pages/browse/browse_page_popular.dart';
import 'package:redditapp/ui/pages/helpers/page_helper.dart';

import 'browse_page.dart';
import 'browse_page_defaults.dart';
import 'browse_page_gold.dart';
import 'browse_page_newest.dart';


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
      widget: BrowsePagePopular(),
      tab: Tab(
        icon: Icon(Icons.add),
      ),
    );
    _pages.add(
      widget: BrowsePageNewest(),
      tab: Tab(
        icon: Icon(Icons.delete),
      ),
    );
    _pages.add(
      widget: BrowsePageDefaults(),
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
        body: MultiBlocProvider(
          providers: [
            BlocProvider<BrowsePopularBloc>(
              create: (context) => BrowsePopularBloc(
                redditRepository: RepositoryProvider.of<RedditRepository>(context),
              )..add(GetPopularSubreddits()),
            ),
            BlocProvider<BrowseNewestBloc>(
              create: (context) => BrowseNewestBloc(
                redditRepository: RepositoryProvider.of<RedditRepository>(context),
              )..add(GetNewestSubreddits()),
            ),
            BlocProvider<BrowseDefaultsBloc>(
              create: (context) => BrowseDefaultsBloc(
                redditRepository: RepositoryProvider.of<RedditRepository>(context),
              )..add(GetDefaultsSubreddits()),
            ),
          ],
          child: TabBarView(
            children: _pages.widgets,
          ),
        ),
      ),
    );
  }
}
