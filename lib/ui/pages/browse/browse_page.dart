import 'package:auto_size_text/auto_size_text.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/blocs/browse/bloc_browse.dart';
import 'package:redditapp/reddit/reddit.dart';
import 'package:redditapp/ui/widgets/loading_widget.dart';

class BrowsePage extends StatefulWidget {
  final BrowseState subredditsState;

  BrowsePage({
    @required this.subredditsState,
  });

  @override
  _BrowsePageState createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  @override
  Widget build(BuildContext context) {
    if (widget.subredditsState is InitialBrowseState) {
      return LoadingWidget();
    } else if (widget.subredditsState is Subreddits) {
      return GridView.count(
        crossAxisCount: 2,
        children:
            List.generate(widget.subredditsState.subreddits.length, (index) {
          return GestureDetector(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Center(
                    child: AutoSizeText(
                  widget.subredditsState.subreddits[index].title,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                )),
              ),
            ),
          );
        }),
      );
    } else {
      return Container();
    }
  }
}
