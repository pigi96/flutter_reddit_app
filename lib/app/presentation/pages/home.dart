import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redditapp/app/presentation/pages/subscribtions/subscriptions_page.dart';
import 'package:redditapp/app/presentation/pages/user/user_page.dart';
import 'package:redditapp/app_style/app_colors.dart';

import 'browse/browse_page.dart';

import 'helpers/page_helper.dart';


class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<Home> with SingleTickerProviderStateMixin {
  Pages _pages;
  PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    print("HOME");
    _pages = new Pages();
    _pageController = PageController(
      initialPage: 0,
    );

    _pages.add(
      widget: BrowsePage(),
      bottomNavigationBarItem: BottomNavigationBarItem(
        icon: Icon(Icons.subject),
        label: 'Browse',
      ),
    );
    _pages.add(
      widget: SubscriptionsPage(),
      bottomNavigationBarItem: BottomNavigationBarItem(
        icon: Icon(Icons.add_box),
        label: 'Subs',
      ),
    );
    _pages.add(
      widget: UserPage(),
      bottomNavigationBarItem: BottomNavigationBarItem(
        icon: Icon(Icons.supervisor_account),
        label: 'Profile',
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
        duration: Duration(milliseconds: 500),
        curve: Curves.decelerate,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages.widgets,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _pages.bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.redditBlueDark,
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
