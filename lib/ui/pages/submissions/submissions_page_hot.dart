import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redditapp/blocs/browse/bloc_browse.dart';
import 'package:redditapp/blocs/submissions/bloc_submissions.dart';
import 'package:redditapp/blocs/submissions/submissions_bloc.dart';
import 'package:redditapp/blocs/submissions/submissions_state.dart';
import 'package:redditapp/ui/pages/submissions/submissions_page.dart';


class SubmissionsPageHot extends StatefulWidget {
  final String title;

  SubmissionsPageHot({
    @required this.title,
  });

  @override
  _SubmissionsPageHotState createState() => _SubmissionsPageHotState();
}

class _SubmissionsPageHotState extends State<SubmissionsPageHot> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubmissionsHotBloc, SubmissionsState>(
      builder: (context, submissionsState) {
        return SubmissionsPage(
          submissionsState: submissionsState,
          submissionsBloc: BlocProvider.of<SubmissionsHotBloc>(context),
          submissionsEvent: GetHotSubmissions(
            title: widget.title,
          ),
        );
      },
    );
  }
}
