import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/submissions/submissions_bloc.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/submissions/submissions_event.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/submissions/submissions_state.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/widgets/loading_widget.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/widgets/submissions_card_widget.dart';

class SubmissionsPage extends StatefulWidget {
  final SubmissionsState submissionsState;
  final SubmissionsBloc submissionsBloc;
  final SubmissionsEvent submissionsEvent;

  SubmissionsPage({
    @required this.submissionsState,
    @required this.submissionsBloc,
    @required this.submissionsEvent,
  });

  @override
  _SubmissionsPageState createState() => _SubmissionsPageState();
}

class _SubmissionsPageState extends State<SubmissionsPage> {
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  ScrollController _scrollController =
      ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController.addListener(() {

    });
  }

  void _onRefresh() async{
    widget.submissionsBloc.add(RefreshSubmissions());
    widget.submissionsBloc.add(widget.submissionsEvent);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    widget.submissionsBloc.add(widget.submissionsEvent);
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.submissionsState is InitialSubmissionsState) {
      return LoadingWidget();
    } else if (widget.submissionsState is Submissions) {
      final List<Submission> submissions = widget.submissionsState.submissions;
      print(submissions.length);
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
        child: ListView.builder(
          itemCount: submissions.length,
          itemBuilder: (context, index) {
            return SubmissionsCardWidget(
              submission: widget.submissionsState.submissions[index],
            );
          },
          ),
        );
    } else {
      return Container();
    }
  }
}
