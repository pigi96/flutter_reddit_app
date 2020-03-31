import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redditapp/blocs/home/bloc_home.dart';

class HomeFragment extends StatefulWidget {
  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
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
    return Scaffold(
      body: SmartRefresher(
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
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, data) {
            if (data is SubredditsLoaded) {
              return GridView.count(
                key: PageStorageKey("home_grid_view"),
                // save state, because well, it's a fragment
                crossAxisCount: 2,
                children: List.generate(data.subreddits.length, (index) {
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      "/subreddit",
                      arguments: data.subreddits[index].title,
                    ),
                    child: Card(
                      margin: new EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 25.0, bottom: 25.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: AutoSizeText(
                            data.subreddits[index].title,
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
