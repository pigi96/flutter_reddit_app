import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redditapp/ui/pages/subscribtions/subscriptions_page_controller.dart';

import 'browse/browse_page_controller.dart';
import 'helpers/page_helper.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<Home> with SingleTickerProviderStateMixin {
  Pages _pages;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = new Pages();

    _pages.add(
      widget: SubscriptionsPageController(),
    );
    _pages.add(
      widget: BrowsePageController(),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.widgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
