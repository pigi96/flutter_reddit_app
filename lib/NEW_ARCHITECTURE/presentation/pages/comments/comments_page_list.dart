
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/comments/comments_state.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/bloc/submissions/bloc_submissions.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/pages/comments/comments_widget.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/widgets/loading_widget.dart';
import 'package:redditapp/NEW_ARCHITECTURE/presentation/widgets/submissions_card_widget.dart';

class CommentsPageList extends StatefulWidget {
  final CommentsState commentsState;

  CommentsPageList(this.commentsState);

  @override
  _CommentsPageListState createState() => _CommentsPageListState();
}

class _CommentsPageListState extends State<CommentsPageList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.commentsState is InitialCommentsState) {
      return SliverToBoxAdapter(child: LoadingWidget());
    } else if (widget.commentsState is LoadSubmission) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            return CommentsWidget(
              comment: widget.commentsState.submission.comments[index],
            );
          },
          childCount: widget.commentsState.submission.comments.length,
        ),
      );
    } else {
      return SliverToBoxAdapter(
        child: LoadingWidget(),
      );
    }
  }
}
