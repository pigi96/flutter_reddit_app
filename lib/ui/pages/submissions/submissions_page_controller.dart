import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/blocs/submissions/submissions_bloc.dart';
import 'package:redditapp/blocs/submissions/submissions_event.dart';
import 'package:redditapp/blocs/submissions/submissions_state.dart';
import 'package:redditapp/repositories/reddit_repository.dart';

import 'package:redditapp/ui/pages/helpers/page_helper.dart';
import 'package:redditapp/ui/pages/submissions/submissions_page.dart';
import 'package:redditapp/ui/pages/submissions/submissions_page_hot.dart';


class SubmissionsPageController extends StatefulWidget {
  final Subreddit subreddit;

  SubmissionsPageController({
    @required this.subreddit,
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
      widget: SubmissionsPageHot(
        title: widget.subreddit.title,
      ),
      tab: Tab(
        text: "Hot",
      ),
    );
    _pages.add(
      widget: SubmissionsPageHot(
        title: widget.subreddit.title,
      ),
      tab: Tab(
        text: "New",
      ),
    );
    _pages.add(
      widget: SubmissionsPageHot(
        title: widget.subreddit.title,
      ),
      tab: Tab(
        text: "Top",
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
            BlocProvider<SubmissionsHotBloc>(
              create: (context) => SubmissionsHotBloc(
                redditRepository: RepositoryProvider.of<RedditRepository>(context),
              )..add(GetHotSubmissions(
                title: widget.subreddit.displayName,
              )),
            ),
            BlocProvider<SubmissionsNewestBloc>(
              create: (context) => SubmissionsNewestBloc(
                redditRepository: RepositoryProvider.of<RedditRepository>(context),
              )..add(GetNewestSubmissions(
                title: widget.subreddit.displayName,
              )),
            ),
            BlocProvider<SubmissionsTopBloc>(
              create: (context) => SubmissionsTopBloc(
                redditRepository: RepositoryProvider.of<RedditRepository>(context),
              )..add(GetTopSubmissions(
                title: widget.subreddit.displayName,
              )),
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
