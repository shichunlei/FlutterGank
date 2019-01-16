import 'package:flutter/material.dart';
import 'package:FlutterGank/http/api.dart';
import 'package:FlutterGank/pages/model/BaseResult.dart';
import 'package:FlutterGank/pages/model/PostData.dart';
import 'package:FlutterGank/utils/http_util.dart';
import 'package:FlutterGank/utils/widgets_utils.dart';
import 'package:FlutterGank/widgets/banner_widget.dart';
import 'package:FlutterGank/widgets/loading_dialog_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  BaseData2 todayData;
  BaseData bannerData;

  List<PostData> banners = [];

  bool isShowDialog = false;

  @override
  void initState() {
    super.initState();

    getBannerData();
    getTodayData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: bulderBodyWidget(),
      onRefresh: _pullToRefresh,
    );
  }

  Widget bulderBodyWidget() {
    if (todayData == null) {
      return LoadingDialogWidget(text: '正在加载...');
    } else if (todayData.error) {
      return WidgetsUtil.buildExceptionIndicator("网络请求错误");
    } else if (todayData.results.length == 0) {
      return WidgetsUtil.buildExceptionIndicator("这里空空的什么都没有呢...");
    } else {
      return ListView(
        children: bulderDailyListView(),
      );
    }
  }

  Future<void> _pullToRefresh() async {
    getBannerData();
    getTodayData();
  }

  void getBannerData() async {
    String url = Api.BANNER_DATA;
    var jsonData = await HttpUtil().get(url);

    bannerData = BaseData.fromJson(jsonData);

    banners.clear();
    for (int i = 0; i < bannerData.results.length; i++) {
      var _value = bannerData.results[i];
      banners.add(PostData.fromJson(_value));
    }

    setState(() {});
  }

  void getTodayData() async {
    String url = Api.TODAY;
    var jsonData = await HttpUtil().get(url);

    todayData = BaseData2.fromJson(jsonData);
    debugPrint("=======");
    debugPrint(todayData.toString());

    setState(() {});
  }

  List<Widget> bulderDailyListView() {
    List<Widget> widgets = [];
    widgets.add(BannerWidget(banners, 200.0));
    for (int i = 0; i < todayData.category.length; i++) {
      debugPrint(todayData.category[i]);
      widgets
        ..add(WidgetsUtil.buildTitleWidget(i, todayData))
        ..addAll(WidgetsUtil.bulderDataView(
            context, todayData.category[i], todayData));
    }

    return widgets;
  }
}
