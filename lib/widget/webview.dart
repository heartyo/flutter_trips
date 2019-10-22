import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const CACH_URLS = ['m.ctrip.com/','m.ctrip.html5/','m.ctrip.com/html5'];

class WebView extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  const WebView(
      {Key key,
      this.url,
      this.statusBarColor,
      this.title,
      this.hideAppBar,
      this.backForbid=false});

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  StreamSubscription _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  StreamSubscription<WebViewHttpError> _onHttpError;

  bool existing = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterWebviewPlugin.close();
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {});

    _onStateChanged = flutterWebviewPlugin.onStateChanged
        .listen((WebViewStateChanged webChange) {
      switch (webChange.type) {
        case WebViewState.startLoad:
          if(_isToMain(webChange.url)){
              if(widget.backForbid) {//禁止返回加载当前页面
                flutterWebviewPlugin.launch(widget.url);
              }else{
                Navigator.pop(context);
                existing = true;

              }
          }
          break;
        default:
          break;
      }
    });
    _onHttpError =
        flutterWebviewPlugin.onHttpError.listen((WebViewHttpError error) {});
  }

  _isToMain(String url){
    bool contain = false;
    for(final value in CACH_URLS){
      if(url?.endsWith(value)??false){
        contain  =true;
        break;
      }
      return contain;

    }

  }
  @override
  void dispose() {
    super.dispose();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    flutterWebviewPlugin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(
              Color(int.parse('0xff' + statusBarColorStr)), backButtonColor),
          Expanded(
              child: WebviewScaffold(
            url: widget.url,
            withZoom: true,
            withLocalStorage: true,
            hidden: true,
            initialChild: Container(
              color: Colors.white,
              child: Center(
                child: Text("Waiting..."),
              ),
            ),
          ))
        ],
      ),
    );
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }
    return Container(
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.title ?? "",
                  style: TextStyle(color: backButtonColor, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
