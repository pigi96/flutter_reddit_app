import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redditapp/blocs/submissions/bloc_submissions.dart';

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
    return Container(
      color: Colors.black12,
    );
  }
}
