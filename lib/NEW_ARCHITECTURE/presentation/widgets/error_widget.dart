import 'package:flutter/cupertino.dart';

class ErrorContainer extends StatefulWidget {
  @override
  _ErrorWidgetState createState() => _ErrorWidgetState();
}

class _ErrorWidgetState extends State<ErrorContainer> {
  @override
  Widget build(BuildContext context) {
    return ErrorWidget(
      Text("Error navigating to page!"),
    );
  }
}