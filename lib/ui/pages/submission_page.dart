import 'package:auto_size_text/auto_size_text.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/blocs/submission/bloc_submission.dart';
import 'package:redditapp/repositories/reddit_repository.dart';

class SubmissionPage extends StatefulWidget {
  @override
  _SubmissionPageState createState() => _SubmissionPageState();
}

class _SubmissionPageState extends State<SubmissionPage> {
  @override
  Widget build(BuildContext context) {
    final String title = ModalRoute.of(context).settings.arguments;
    
    return BlocProvider<SubmissionBloc>(
      create: (BuildContext context) => SubmissionBloc(
        redditRepository: RepositoryProvider.of<RedditRepository>(context),
      )..add(LoadSubmissionsTop(
        title: title,
      )),
      child: Container(
        child: BlocBuilder<SubmissionBloc, SubmissionState>(
          builder: (context, submissions) {
            if (submissions is SubmissionsLoaded) {
              return GridView.count(
                key: PageStorageKey("subreddit_page"),
                crossAxisCount: 1,
                children: List.generate(submissions.submissions.length, (index) {
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
                        child: BlocBuilder<SubmissionBloc, SubmissionState>(
                          builder: (context, submissions) {
                            if (submissions is SubmissionsLoaded &&
                            submissions.submissions[index].preview.isNotEmpty) {
                              return Column(
                                children: <Widget>[
                                  AutoSizeText(
                                    submissions.submissions[index].title,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                    maxLines: 10,
                                    textAlign: TextAlign.center,
                                  ),
                                  Image.network(
                                    submissions.submissions[index].preview[0].source.url.toString(),
                                    fit: BoxFit.fill,
                                  ),
                                ],
                              );
                            } else if (submissions is SubmissionsLoaded) {
                              return Column(
                                children: <Widget>[
                                  AutoSizeText(
                                    submissions.submissions[index].title,
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
    );
  }
}
