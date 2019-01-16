import 'package:FlutterGank/pages/model/CategoryData.dart';
import 'package:FlutterGank/pages/xiandu/XianduTabPage.dart';
import 'package:flutter/material.dart';

class XianduPage extends StatefulWidget {
  List<SubCategory> categorys;
  String title;

  XianduPage({Key key, @required this.title, @required this.categorys})
      : super(key: key);

  @override
  _XianduPageState createState() => _XianduPageState();
}

class _XianduPageState extends State<XianduPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  TabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: widget.categorys.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          tabs: tabs(),
          controller: _controller,
          indicatorColor: Theme.of(context).primaryColor,
          isScrollable: true,
        ),
      ),
      body: TabBarView(
        children: getTabBarView(),
        controller: _controller,
      ),
    );
  }

  List<Tab> tabs() {
    List<Tab> _tabs = [];
    for (int i = 0; i < widget.categorys.length; i++) {
      _tabs.add(Tab(
        text: widget.categorys[i].title,
      ));
    }
    return _tabs;
  }

  List<Widget> getTabBarView() {
    List<Widget> tabBarViews = [];

    for (int i = 0; i < widget.categorys.length; i++) {
      tabBarViews.add(XianduTabPage(id: widget.categorys[i].id));
    }
    return tabBarViews;
  }
}
