import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_fragment.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TabBar(
              controller: _controller,
              tabs: [
                Tab(icon: new Icon(Icons.directions_car)),
                Tab(icon: new Icon(Icons.directions_transit)),
                Tab(icon: new Icon(Icons.directions_bike)),
              ],
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          HomeFragment(),
          HomeFragment(),
          HomeFragment(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
