import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: ListView(
              children: <Widget>[
                Container(
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
                ),
                Container(
                  height: 800,
                  child: ListTile(
                    title: Text('哈哈'),
                  ),
                )
              ],
            ),
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
}
