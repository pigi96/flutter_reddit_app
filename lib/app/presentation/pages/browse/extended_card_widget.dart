import 'package:cached_network_image/cached_network_image.dart';
import 'package:draw/draw.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:redditapp/app/presentation/bloc/subscriptions_info/subscriptions_info_bloc.dart';
import 'package:redditapp/app/presentation/bloc/subscriptions_info/subscriptions_info_event.dart';
import 'package:redditapp/app/presentation/bloc/subscriptions_info/subscriptions_info_state.dart';
import 'package:redditapp/app/presentation/pages/submissions/submissions_page.dart';
import 'package:redditapp/app_style/app_colors.dart';

class ExtendedCardWidget extends StatefulWidget {
  @override
  _ExtendedCardWidgetState createState() => _ExtendedCardWidgetState();
}

class _ExtendedCardWidgetState extends State<ExtendedCardWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionsInfoBloc, SubscriptionsInfoState>(
      builder: (context, subscriptionsInfoState) {
        final subreddit = subscriptionsInfoState.subreddit;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ExpansionTileCard(
            leading: ClipOval(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
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
            title: Text(subreddit.title,),
            subtitle: Text("Tap to load more",
            style: TextStyle(color: AppColors.redditGrey),),
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 0.0,
                  ),
                  child: Center(
                    child: Text(description(subreddit),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .body1
                          .copyWith(fontSize: 16),
                    ),
                  ),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                buttonHeight: 52.0,
                buttonMinWidth: 90.0,
                children: <Widget>[
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                    onPressed: () {
                      Route route = MaterialPageRoute(
                        builder: (context) => SubmissionsPage(
                          subreddit: subreddit,
                        ),
                      );
                      Navigator.push(context, route);
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.adjust),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Text('Open'),
                      ],
                    ),
                  ),
                  subscribeButton(context, subreddit),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

FlatButton subscribeButton(BuildContext context, Subreddit subreddit) {
  bool isSubscribed = subreddit.data["user_is_subscriber"];
  IconData icon;
  String text;
  if (isSubscribed) {
    text = "Leave";
    icon = Icons.do_not_disturb_alt;
  } else {
    text = "Join";
    icon = Icons.add_circle_outline;
  }

  return FlatButton(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    onPressed: () {
      BlocProvider.of<SubscriptionsInfoBloc>(context)
          .add(Subscribe(subreddit: subreddit));
    },
    child: Column(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
        ),
        Text(text),
      ],
    ),
  );
}

String description(Subreddit subreddit) {
  String desc = subreddit.data["public_description"];
  if (desc.length == 0) {
    desc = subreddit.title;
  }
  return desc;
}