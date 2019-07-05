import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  @override
  MyPageState createState() => new MyPageState();
}

class MyPageState extends State<MyPage> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body: Center(
       child: Text('我的'),
     )
    );
  }

}