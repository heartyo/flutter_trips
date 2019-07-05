import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trips/dao/home_dao.dart';
import 'package:flutter_trips/model/common_model.dart';
import 'package:flutter_trips/model/grid_nav_model.dart';
import 'package:flutter_trips/model/home_model.dart';
import 'package:flutter_trips/model/sales_box_model.dart';
import 'package:flutter_trips/widget/local_nav.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  List _imageUrls = [
    'http://pic9.nipic.com/20100923/2531170_140325352643_2.jpg',
    'http://pic15.nipic.com/20110628/1369025_192645024000_2.jpg',
    'http://pic41.nipic.com/20140508/18609517_112216473140_2.jpg'
  ];

  double appBarAlpha = 0;
  String netString = "aa";
  List<CommonModel> localNavList = [];
  List<CommonModel> bannerList = [];
  List<CommonModel> subNavList = [];
  GridNavModel gridNavModel;
  SalesBoxModel salesBoxModel;
  bool _loading = true;

  _loadData() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        netString = json.encode(model.config);
        localNavList = model.localNavList;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xf2f2f2),
        body: Stack(
      children: <Widget>[
        MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: NotificationListener(
            onNotification: (scrollNotifaction) {
              if (scrollNotifaction is ScrollUpdateNotification &&
                  scrollNotifaction.depth == 0) {
                _onScroll(scrollNotifaction.metrics.pixels);
              }
            },
            child: _ListView,
          ),
        ),
        Opacity(
          opacity: appBarAlpha,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('首页'),
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Widget get _ListView {
    return ListView(
      children: <Widget>[
        _banner,
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: LocalNav(localNavList: localNavList),
        ),
      ],
    );
  }

  Widget get _banner {
    return Container(
      height: 220,
      child: Swiper(
        itemCount: _imageUrls.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            _imageUrls[index],
            fit: BoxFit.fill,
          );
        },
        pagination: SwiperPagination(),
      ),
    );
  }

  _onScroll(offsets) {
    double alpha = offsets / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print(appBarAlpha);
  }

  Future<http.Response> fetchGet() {
    return http.get('');
  }
}
