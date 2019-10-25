import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trips/dao/home_dao.dart';
import 'package:flutter_trips/model/common_model.dart';
import 'package:flutter_trips/model/grid_nav_model.dart';
import 'package:flutter_trips/model/home_model.dart';
import 'package:flutter_trips/model/sales_box_model.dart';
import 'package:flutter_trips/widget/loading_container.dart';
import 'package:flutter_trips/widget/local_nav.dart';
import 'package:flutter_trips/widget/grid_nav.dart';
import 'package:flutter_trips/widget/sales_box.dart';
import 'package:flutter_trips/widget/sub_nav.dart';
import 'package:flutter_trips/widget/webview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  double appBarAlpha = 0;
  String netString = "aa";
  List<CommonModel> localNavList = [];
  List<CommonModel> bannerList = [];
  List<CommonModel> subNavList = [];
  GridNavModel gridNavModel;
  SalesBoxModel salesBoxModel;
  bool _loading = true;

  Future<Null> _handleRefesh() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        netString = json.encode(model.config);
        localNavList = model.localNavList;
        bannerList = model.bannerList;
        subNavList = model.subNavList;
        gridNavModel = model.gridNav;
        salesBoxModel = model.salesBox;
        _loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _handleRefesh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xf2f2f2),
        body: LoadingContainer(
          isLoading: _loading,
          child: Stack(
            children: <Widget>[
              MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: RefreshIndicator(
                      child: NotificationListener(
                        onNotification: (scrollNotifaction) {
                          if (scrollNotifaction is ScrollUpdateNotification &&
                              scrollNotifaction.depth == 0) {
                            _onScroll(scrollNotifaction.metrics.pixels);
                          }
                        },
                        child: _ListView,
                      ),
                      onRefresh: _handleRefesh)),
              _appBar,
            ],
          ),
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
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: GridNav(
            gridNavModel: gridNavModel,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SubNav(
            subNavList: subNavList,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SalesBox(salebox: salesBoxModel),
        ),
      ],
    );
  }

  Widget get _appBar {
    return Opacity(
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
    );
  }

  Widget get _banner {
    return Container(
      height: 220,
      child: Swiper(
        itemCount: bannerList.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                CommonModel model = bannerList[index];
                return WebView(
                  url: model.url,
                  statusBarColor: model.statusBarColor,
                  title: model.title,
                  hideAppBar: model.hideAppBar,
                );
              }));
            },
            child: Image.network(
              bannerList[index].icon,
              fit: BoxFit.fill,
            ),
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
