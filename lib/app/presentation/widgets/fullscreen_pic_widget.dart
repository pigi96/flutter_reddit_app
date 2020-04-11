import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redditapp/app/presentation/bloc/submissions_info/submissions_info_state.dart';
import 'package:redditapp/app/presentation/pages/submissions/submissions_card_widget.dart';
import 'package:redditapp/helpers/stuff.dart';

class FullscreenPicWidget extends StatefulWidget {
  final SubmissionsInfoState submissionInfo;

  FullscreenPicWidget(this.submissionInfo);

  @override
  _FullscreenPicWidgetState createState() => _FullscreenPicWidgetState();
}

class _FullscreenPicWidgetState extends State<FullscreenPicWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(backgroundColor: Colors.black38,),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: checkForUrl(widget.submissionInfo.submission.preview),
          //fit: BoxFit.fitWidth,
          //width: double.infinity,
          alignment: Alignment.center,
          height: placeholderHeight(context, widget.submissionInfo),
          width: double.infinity,
        ),
      ),
    );
  }
}
