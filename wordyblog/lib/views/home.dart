import 'package:flutter/material.dart';
import 'package:wordyblog/views/post.dart';
import 'package:wordyblog/wpapi.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Footyfans"),
      ),
      body: Container(
          child: FutureBuilder(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Map wppost = snapshot.data[index];
                  return PostTile(
                      href: wppost["_links"]["wp:featuredmedia"][0]["href"],
                      title: wppost["title"]["rendered"],
                      desc: wppost["excerpt"]["rendered"],
                      content: wppost["content"]["rendered"]);
                });
          }
          return CircularProgressIndicator();
        },
      )),
    );
  }
}

class PostTile extends StatefulWidget {
  final String href, title, desc, content;
  PostTile({this.content, this.title, this.desc, this.href});

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  var imageUrl = "";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Post(
                    imageUrl: imageUrl,
                    title: widget.title,
                    desc: widget.content)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: fetchPostImageUrl(widget.href),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  imageUrl = snapshot.data["guid"]["rendered"];
                  return Image.network(snapshot.data["guid"]["rendered"]);
                }
                return CircularProgressIndicator();
              },
            ),
            SizedBox(height: 8),
            Text(widget.title, style: TextStyle(fontSize: 18)),
            SizedBox(height: 5),
            Text(widget.desc)
          ],
        ),
      ),
    );
  }
}
