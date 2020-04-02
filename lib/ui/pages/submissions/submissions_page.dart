import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/blocs/submissions/bloc_submissions.dart';
import 'package:redditapp/blocs/subscriptions/subscriptions_state.dart';

class SubmissionsPage extends StatefulWidget {
  SubmissionsEvent dataEvent;

  SubmissionsPage({
    @required this.dataEvent,
  });

  @override
  _SubmissionsPageState createState() => _SubmissionsPageState();
}

class _SubmissionsPageState extends State<SubmissionsPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
