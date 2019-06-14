import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  @override
  MyPageState createState() => new MyPageState();
}

class MyPageState extends State<MyPage> {
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