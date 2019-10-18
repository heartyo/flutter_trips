import 'package:flutter/material.dart';
import 'package:flutter_trips/model/grid_nav_model.dart';
class GridNav extends StatefulWidget {

  final GridNavModel gridNavModel;
  final String name;

  const GridNav({Key key, this.gridNavModel, this.name}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GridNavState();

}

class _GridNavState extends State<GridNav>{
  @override
  Widget build(BuildContext context) {

    return Text("");
  }

}


