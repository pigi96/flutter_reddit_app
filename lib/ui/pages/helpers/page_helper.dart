import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pages {
  /// [widgets] holds data about a certain page.
  List<Widget> widgets = List<Widget>();

  /// Set up [tabs] if the page has an app tab bar.
  List<Tab> tabs = List<Tab>();

  /// Set bottom navigation bar items if needed.
  List<BottomNavigationBarItem> bottomNavigationBarItems =
      List<BottomNavigationBarItem>();

  add({
    @required Widget widget,
    Tab tab,
    BottomNavigationBarItem bottomNavigationBarItem,
  }) {
    this.widgets.add(widget);
    if (this.tabs != null) tabs.add(tab);
    if (bottomNavigationBarItem != null)
      bottomNavigationBarItems.add(bottomNavigationBarItem);
  }

  get length => widgets.length;
}
