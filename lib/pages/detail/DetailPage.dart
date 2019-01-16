import 'package:flutter_html_widget/flutter_html_widget.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  String title;
  String content;

  DetailPage({
    Key key,
    @required this.title,
    @required this.content,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    debugPrint(widget.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[HtmlWidget(html: widget.content)],
      ),
    );
  }
}
