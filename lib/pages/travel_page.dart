import 'package:flutter/material.dart';

class TravelPage extends StatefulWidget {
  @override
  TravelPageState createState() => new TravelPageState();
}

class TravelPageState extends State<TravelPage> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body: Center(
       child: Text('旅拍'),
     )
    );
  }

}