import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redditapp/blocs/submissions/bloc_submissions.dart';
import 'package:redditapp/blocs/subscriptions/subscriptions_state.dart';
import 'package:redditapp/ui/widgets/extended_card_widget.dart';
import 'package:redditapp/ui/widgets/loading_widget.dart';
import 'package:redditapp/ui/widgets/submissions_card_widget.dart';

class SubmissionsPage extends StatefulWidget {
  final SubmissionsState submissionsState;

  SubmissionsPage({
    @required this.submissionsState,
  });

  @override
  _SubmissionsPageState createState() => _SubmissionsPageState();
}

class _SubmissionsPageState extends State<SubmissionsPage> {
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.submissionsState is InitialSubmissionsState) {
      return LoadingWidget();
    } else if (widget.submissionsState is Submissions) {
      final List<Submission> submissions = widget.submissionsState.submissions;
      return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text("pull up load");
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = Text("Load Failed!Click retry!");
            }
            else if(mode == LoadStatus.canLoading){
              body = Text("release to load more");
            }
            else{
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView(
          children: List.generate(
            submissions.length,
            (index) {
              return SubmissionsCardWidget(
                submission: widget.submissionsState.submissions[index],
              );
            },
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
