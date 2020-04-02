import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    if (widget.submissionsState is InitialSubmissionsState) {
      return LoadingWidget();
    } else if (widget.submissionsState is Submissions) {
      final List<Submission> submissions = widget.submissionsState.submissions;
      return ListView(
        children: List.generate(
          submissions.length,
          (index) {
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
