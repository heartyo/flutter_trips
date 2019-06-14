import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body: Center(
       child: Text('首页'),
     )
    );
  }

}