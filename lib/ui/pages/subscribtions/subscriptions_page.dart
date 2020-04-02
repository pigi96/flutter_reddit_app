import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/blocs/subscriptions/bloc_subscriptions.dart';
import 'package:redditapp/ui/widgets/loading_widget.dart';

class SubscriptionsPage extends StatefulWidget {
  final SubscriptionsEvent dataEvent;

  SubscriptionsPage({
    @required this.dataEvent,
  });

  @override
  _SubscriptionsPageState createState() => _SubscriptionsPageState();
}

class _SubscriptionsPageState extends State<SubscriptionsPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SubscriptionsBloc>(context).add(widget.dataEvent);

    return BlocBuilder<SubscriptionsBloc, SubscriptionsState>(
      builder: (context, subscriptions) {
        if (subscriptions is InitialSubscriptionsState) {
          return LoadingWidget();
        } else {
          return GridView.count(
            crossAxisCount: 2,
            children: List.generate(subscriptions.subreddits.length, (index) {
              return GestureDetector(
                child: Card(
                  child: Text(subscriptions.subreddits[index].title),
                ),
              );
            }),
          );
        }
      }
    );
  }
}










/*return BlocProvider<SubscriptionsBloc>(
      create: (BuildContext context) => SubscriptionsBloc(
        redditRepository: RepositoryProvider.of<RedditRepository>(context),
      )..add(GetDefaultSubscriptions(),),
      child: Container(
        child: BlocBuilder<SubscriptionsBloc, SubscriptionsState>(
          builder: (context, subscriptions) {
            if (subscriptions is DefaultSubscriptions) {
              return GridView.count(
                key: PageStorageKey("subreddit_page"),
                crossAxisCount: 1,
                children: List.generate(subscriptions.subreddits.length, (index) {
                  return GestureDetector(
                    child: Card(
                      margin: new EdgeInsets.only(
                          top: 25.0,
                          bottom: 25.0
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: BlocBuilder<SubscriptionsBloc, SubscriptionsState>(
                          builder: (context, subscriptions) {
                            if (subscriptions is DefaultSubscriptions) {
                              return Column(
                                children: <Widget>[
                                  AutoSizeText(
                                    subscriptions.subreddits[index].title,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                    maxLines: 10,
                                    textAlign: TextAlign.center,
                                  ),
                                  Image.network(
                                    subscriptions.subreddits[index].title,
                                    fit: BoxFit.fill,
                                  ),
                                ],
                              );
                            } else if (subscriptions is DefaultSubscriptions) {
                              return Column(
                                children: <Widget>[
                                  AutoSizeText(
                                    subscriptions.subreddits[index].title,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                    maxLines: 10,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              );
                            }
                            return Container();
                          },
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
    );*/
