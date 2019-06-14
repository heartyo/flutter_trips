import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  SearchPageState createState() => new SearchPageState();
}

class SearchPageState extends State<SearchPage> {
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