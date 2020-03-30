import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/blocs/home/bloc_home.dart';

class HomeFragment extends StatefulWidget {
  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(LoadSubreddits());

    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, data) {
          if (data is SubredditsLoaded) {
            return GridView.count(
              key: PageStorageKey("home_grid_view"),
              // save state, because well, it's a fragment
              crossAxisCount: 2,
              children: List.generate(100, (index) {
                return Card(
                  margin: new EdgeInsets.only(
                      left: 20.0, right: 10.0, top: 10.0, bottom: 10.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 4.0,
                  child: Center(
                    child: Text(
                    data.subreddits[index].title,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline,
                  ),
                ),);
              }),
            );
          }
          return Container();
        },
      ),
    );
  }
}
