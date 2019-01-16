import 'package:flutter/material.dart';
import 'package:FlutterGank/common/GlobalConfig.dart';
import 'package:FlutterGank/pages/classify/ClassifyTabPage.dart';

class ClassifyPage extends StatefulWidget {
  @override
  _ClassifyPageState createState() => _ClassifyPageState();
}

class _ClassifyPageState extends State<ClassifyPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  TabController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        TabController(length: GlobalConfig.CLASSIFY_TITLES.length, vsync: this);
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
        title: TabBar(
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
    for (int i = 0; i < GlobalConfig.CLASSIFY_TITLES.length; i++) {
      _tabs.add(Tab(
        text: GlobalConfig.CLASSIFY_TITLES[i],
      ));
    }
    return _tabs;
  }

  List<Widget> getTabBarView() {
    List<Widget> tabBarViews = [];

    for (int i = 0; i < GlobalConfig.CLASSIFY_TITLES.length; i++) {
      tabBarViews.add(ClassifyTabPage(title: GlobalConfig.CLASSIFY_TITLES[i]));
    }
    return tabBarViews;
  }
}
