import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redditapp/app/presentation/bloc/submissions/bloc_submissions.dart';
import 'package:redditapp/app/presentation/widgets/loading_widget.dart';
import 'package:redditapp/app/presentation/widgets/submissions_card_widget.dart';

class SubmissionsPageList extends StatefulWidget {
  final SubmissionsState submissionsState;

  SubmissionsPageList(this.submissionsState);

  @override
  _SubmissionsPageListState createState() => _SubmissionsPageListState();
}

class _SubmissionsPageListState extends State<SubmissionsPageList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.submissionsState is InitialSubmissionsState) {
      return SliverToBoxAdapter(child: LoadingWidget());
    } else if (widget.submissionsState is Submissions) {
      final List<Submission> submissions = widget.submissionsState.submissions;
      return SliverList(
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            return SubmissionsCardWidget(
              submission: submissions[index],
            );
          },
          childCount: submissions.length,
        ),
      );
    } else {
      return SliverToBoxAdapter(
        child: LoadingWidget(),
      );
    }
  }
}
