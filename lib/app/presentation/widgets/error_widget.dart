import 'package:animator/animator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/app_style/app_colors.dart';
import 'package:redditapp/core/errors/failures.dart';

class ErrorContainer extends StatefulWidget {
  final Failure failure;

  final action;
  final event;

  ErrorContainer(
    this.failure, {
    this.action,
    this.event,
  });

  @override
  _ErrorWidgetState createState() => _ErrorWidgetState();
}

class _ErrorWidgetState extends State<ErrorContainer> {
  @override
  Widget build(BuildContext context) {
    Failure failure = widget.failure;
    print(failure);
    if (failure is GeneralFailure) {
      return TweenAnimationBuilder(
        tween: Tween<double>(begin: 100, end: -20),
        duration: Duration(milliseconds: 400),
        builder: (BuildContext context, double translation, Widget child) {
          return Transform.translate(
            offset: Offset(0.0, translation),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: RaisedButton.icon(
                  icon: Icon(Icons.tag_faces, color: Colors.white,),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 2.0,
                  color: AppColors.redditBlueDark,
                  label: Text(
                    "Something is not a-okay!",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    widget.action.add(widget.event);
                  },
                ),
              ),
            ),
          );
        },
      );
    } else {
      // not possible for now
      return Container();
    }
  }
}
