import 'package:flutter/material.dart';

class TabNavigator extends StatefulWidget {
  @override
  TabNavigatorState createState() => new TabNavigatorState();
}

class TabNavigatorState extends State<TabNavigator> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body: PageView(
       controller: _pageController,
       children: <Widget>[

       ],
     ),
    );
  }

}