

import 'package:animator/animator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redditapp/core/errors/failures.dart';

class ErrorContainer extends StatefulWidget {
  final Failure failure;

  final action;
  final event;

  ErrorContainer(this.failure, {
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
        tween: Tween<double>(begin: 100, end: 0),
        duration: Duration(seconds: 1),
        builder: (BuildContext context, double translation, Widget child)  {
          return Transform.translate(
            offset: Offset(0.0, translation),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: RaisedButton(
                  elevation: 3.0,
                  color: Colors.white70,
                  child: Text("Something is wrong!", style: TextStyle(color: Colors.black),),
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