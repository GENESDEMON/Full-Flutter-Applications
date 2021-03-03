import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

class Post extends StatefulWidget {
  final String imageUrl, title, desc;
  Post({this.desc, this.imageUrl, this.title});
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  Widget content(htmlContent) {
    return HtmlView(
      data: htmlContent,
      onLaunchFail: (url) {
        print("launch $url failed");
      },
      scrollable: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: [
            Image.network(widget.imageUrl),
            Text(widget.title),
            content(widget.desc)
          ],
        ),
      ),
    );
  }
}
