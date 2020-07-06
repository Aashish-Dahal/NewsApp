import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class ArticleView extends StatefulWidget {
  final String imageUrl;

  const ArticleView({Key key, this.imageUrl}) : super(key: key);

  @override
  _ArticleViewState createState() => _ArticleViewState();

}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> _completer=Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Flutter'),
            Text('News',style: TextStyle(
              color: Colors.blue,
            ),)
          ],
        ),
      ),
      body: Container(
        child: WebView(
          initialUrl:widget.imageUrl ,
          onWebViewCreated: ((WebViewController webViewController  ){
            _completer.complete(webViewController);
          }),
        ),
      ),
    );
  }
}
