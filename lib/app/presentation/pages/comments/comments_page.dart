import 'package:draw/draw.dart' as draw;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redditapp/app/presentation/bloc/comments/comments_bloc.dart';
import 'package:redditapp/app/presentation/bloc/comments/comments_event.dart';
import 'package:redditapp/app/presentation/bloc/comments/comments_state.dart';
import 'package:redditapp/injection_container.dart';

import 'comments_page_list.dart';

class CommentsPage extends StatefulWidget {
  final draw.Submission submission;

  CommentsPage({@required this.submission});

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  RefreshController _refreshController =
    RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
  }

  void _onRefresh(BuildContext context) async {
    // monitor network fetch
    // if failed,use refreshFailed()


  }

  void _onLoading(BuildContext context) async {
    // monitor network fetch
    // if failed,use loadFailed(),if no data return,use LoadNodata()


  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommentsBloc>(
      create: (context) => sl<CommentsBloc>()..add(GetComments(
        submission: widget.submission,
      )),
      child: BlocBuilder<CommentsBloc, CommentsState>(
        builder: (context, commentsState) {
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
                  //SubmissionsPageAppbar(widget.subreddit),
                  CommentsPageList(commentsState),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
