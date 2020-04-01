import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pages {
  /// [widgets] holds data about a certain page.
  List<Widget> widgets = List<Widget>();
  /// Set up [tabs] if the page has an app tab bar.
  List<Tab> tabs = List<Tab>();

  add({
    @required Widget widget,
   Tab tab,
  }) {
    widgets.add(widget);
    tabs.add(tab);
  }

  get length => widgets.length;
}