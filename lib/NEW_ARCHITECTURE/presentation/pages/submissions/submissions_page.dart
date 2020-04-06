import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/submissions/bloc_submissions.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/submissions/submissions_bloc.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/pages/submissions/submissions_page_appbar.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/pages/submissions/submissions_page_cover.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/pages/submissions/submissions_page_list.dart';
import 'package:redditapp/injection_container.dart';

class SubmissionsPage extends StatefulWidget {
  final Subreddit subreddit;

  SubmissionsPage({@required this.subreddit});

  @override
  _SubmissionsPageState createState() => _SubmissionsPageState();
}

class _SubmissionsPageState extends State<SubmissionsPage> {
  SubmissionsEvent currentSubmissionsEvent;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    currentSubmissionsEvent = GetHotSubmissions(
      title: widget.subreddit.displayName,
    );
  }

  void _onRefresh(BuildContext context) async {
    // monitor network fetch
    // if failed,use refreshFailed()
    BlocProvider.of<SubmissionsBloc>(context).add(RefreshSubmissions());
    BlocProvider.of<SubmissionsBloc>(context).add(currentSubmissionsEvent);
   
  }

  void _onLoading(BuildContext context) async {
    // monitor network fetch
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    BlocProvider.of<SubmissionsBloc>(context).add(currentSubmissionsEvent);

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SubmissionsBloc>(
      create: (context) => sl<SubmissionsBloc>()..add(currentSubmissionsEvent),
      child: BlocBuilder<SubmissionsBloc, SubmissionsState>(
        builder: (context, submissionsState) {
          currentSubmissionsEvent = submissionsState.submissionsEvent;
          _refreshController.refreshCompleted();
          _refreshController.loadComplete();
          return Scaffold(
            body: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropMaterialHeader(
                backgroundColor: Colors.orange,
              ),
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("pull up load");
                  } else if (mode == LoadStatus.loading) {
                    body = CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("Load Failed!Click retry!");
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("release to load more");
                  } else {
                    body = Text("No more Data");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              controller: _refreshController,
              onRefresh: () => _onRefresh(context),
              onLoading: () => _onLoading(context),
              child: CustomScrollView(
                slivers: <Widget>[
                  SubmissionsPageCover(widget.subreddit),
                  SubmissionsPageAppbar(widget.subreddit),
                  SubmissionsPageList(submissionsState),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
