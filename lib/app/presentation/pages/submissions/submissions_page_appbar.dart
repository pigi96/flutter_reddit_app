import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/app/presentation/bloc/browse/bloc_browse.dart';
import 'package:redditapp/app/presentation/bloc/browse/browse_bloc.dart';
import 'package:redditapp/app/presentation/bloc/submissions/submissions_bloc.dart';
import 'package:redditapp/app/presentation/bloc/submissions/submissions_event.dart';
import 'package:redditapp/app/presentation/bloc/submissions/submissions_state.dart';
import 'package:redditapp/app_style/app_colors.dart';
import 'package:redditapp/helpers/text_editor.dart';

class SubmissionsPageAppbar extends StatefulWidget {
  final Subreddit subreddit;

  SubmissionsPageAppbar(this.subreddit);

  @override
  _SubmissionsPageAppbarState createState() => _SubmissionsPageAppbarState();
}

class _SubmissionsPageAppbarState extends State<SubmissionsPageAppbar> {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: false,
      floating: true,
      delegate: CustomSliverDelegate(
        expandedHeight: 140,
        subreddit: widget.subreddit,
      ),
    );

    return SliverAppBar(
      expandedHeight: 200.0,
      pinned: false,
      snap: false,
      floating: false,
      backgroundColor: Colors.grey[900],
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
            widget.subreddit.title,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {

          },
        ),
      ],
    );
  }
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;
  final Subreddit subreddit;

  CustomSliverDelegate({
    @required this.expandedHeight,
    this.hideTitleWhenExpanded = true,
    @required this.subreddit,
  });


  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    final cardTopPosition = expandedHeight / 2 - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return SizedBox(
      height: expandedHeight + expandedHeight / 2,
      child: Stack(
        children: [
          SizedBox(
            height: appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize,
            child: AppBar(
              backgroundColor: AppColors.redditOrange,
              elevation: 0.0,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () => dialogOptions(context, subreddit),
                ),
              ],
              flexibleSpace: Opacity(
                opacity: hideTitleWhenExpanded ? 0.0 + percent : 0.0,
                child: CachedNetworkImage(
                  imageUrl: subreddit.mobileHeaderImage.toString(),
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
              ),
              title: Opacity(
                  opacity: hideTitleWhenExpanded ? 1.0 - percent : 1.0,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(subreddit.path,),
                  )),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: cardTopPosition > 0 ? cardTopPosition : 0,
            bottom: 0.0,
            child: IgnorePointer(
              child: Opacity(
                opacity: percent,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15 * percent),
                  child: Card(
                    elevation: 20.0,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: subreddit.iconImage.toString(),
                                      placeholder: (context, url) => Icon(
                                        Icons.ac_unit,
                                        size: 35.0,
                                        color: AppColors.redditBlueLight,
                                      ),
                                      errorWidget: (context, url, error) => Icon(
                                        Icons.ac_unit,
                                        size: 35.0,
                                        color: AppColors.redditBlueDark,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.0,),
                              Text(subreddit.path,
                              style: TextStyle(
                                color: Colors.redAccent,
                              ),),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                                child: Text("Subs: ${(subscribersCount(subreddit.data["subscribers"]))}"),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 15.0),
                            child: AutoSizeText(description(subreddit), maxLines: 4, overflow: TextOverflow.ellipsis,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  void dialogOptions(BuildContext context, Subreddit subreddit) {
     AwesomeDialog(
      context: context,
      animType: AnimType.BOTTOMSLIDE,
      dialogType: DialogType.INFO,
      body: Column(
        children: <Widget>[
          FlatButton(
            child: Text("Hot"),
            onPressed: () {
              BlocProvider.of<SubmissionsBloc>(context).add(RefreshSubmissions());
              BlocProvider.of<SubmissionsBloc>(context).add(GetHotSubmissions(
                title: subreddit.displayName,
              ));
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text("Newest"),
            onPressed: () {
              BlocProvider.of<SubmissionsBloc>(context).add(RefreshSubmissions());
              BlocProvider.of<SubmissionsBloc>(context).add(GetNewestSubmissions(
                title: subreddit.displayName,
              ));
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text("Top"),
            onPressed: () {
              BlocProvider.of<SubmissionsBloc>(context).add(RefreshSubmissions());
              BlocProvider.of<SubmissionsBloc>(context).add(GetTopSubmissions(
                title: subreddit.displayName,
              ));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      title: 'This is Ignored',
      desc:   'This is also Ignored',
      btnCancelOnPress: () {},
    ).show();
  }
}

String description(Subreddit subreddit) {
  String desc = subreddit.data["public_description"];
  if (desc.length == 0) {
    desc = subreddit.title;
  }
  return desc;
}
