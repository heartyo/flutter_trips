import 'package:flutter/material.dart';
import 'package:flutter_trips/pages/home_page.dart';
import 'package:flutter_trips/pages/my_page.dart';
import 'package:flutter_trips/pages/search_page.dart';
import 'package:flutter_trips/pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  TabNavigatorState createState() => new TabNavigatorState();
}

class TabNavigatorState extends State<TabNavigator> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  final _defaltColor = Colors.grey;
  final _activieColor = Colors.blue;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomePage(),
          SearchPage(),
          TravelPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index){
          _pageController.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });

        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _defaltColor,
              ),
              activeIcon: Icon(
                Icons.home,
                color: _activieColor,
              ),
              title: Text(
                '首页',
                style: TextStyle(
                  color: _currentIndex != 0 ? _defaltColor : _activieColor,
                ),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: _defaltColor,
              ),
              activeIcon: Icon(
                Icons.search,
                color: _activieColor,
              ),
              title: Text(
                '搜索',
                style: TextStyle(
                  color: _currentIndex != 1 ? _defaltColor : _activieColor,
                ),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.camera_alt,
                color: _defaltColor,
              ),
              activeIcon: Icon(
                Icons.camera_alt,
                color: _activieColor,
              ),
              title: Text(
                '旅拍',
                style: TextStyle(
                  color: _currentIndex != 2 ? _defaltColor : _activieColor,
                ),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                color: _defaltColor,
              ),
              activeIcon: Icon(
                Icons.account_circle,
                color: _activieColor,
              ),
              title: Text(
                '我的',
                style: TextStyle(
                  color: _currentIndex != 3 ? _defaltColor : _activieColor,
                ),
              ))
        ],
      ),
    );
  }
}
