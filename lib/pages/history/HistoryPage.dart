import 'package:FlutterGank/common/GlobalConfig.dart';
import 'package:FlutterGank/pages/model/BaseResult.dart';
import 'package:FlutterGank/pages/model/PostData.dart';
import 'package:FlutterGank/utils/route_util.dart';
import 'package:FlutterGank/widgets/loading_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:FlutterGank/http/api.dart';
import 'package:FlutterGank/pages/history/HistoryDataPage.dart';
import 'package:FlutterGank/utils/http_util.dart';
import 'package:FlutterGank/utils/toast_util.dart';
import 'package:FlutterGank/utils/widgets_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  RefreshController _refreshController;

  int page = 1;
  int pagesize = 20;

  var requestError = false;

  BaseData data;
  List<PostData> list = [];

  void enterRefresh() {
    _refreshController.requestRefresh(true);
  }

  @override
  void initState() {
    super.initState();
    _refreshController = new RefreshController();
    getHistoryDate(page, pagesize, GlobalConfig.DEFAULT);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("历史")),
      body: _buildBodyView(),
    );
  }

  _buildBodyView() {
    if (data == null) {
      return LoadingDialogWidget(text: "正在加载...");
    } else if (data.error) {
      return WidgetsUtil.buildExceptionIndicator("网络请求失败");
    } else if (page > 1 && data.results.length == 0) {
      ToastUtil.show("数据加载完毕", context);
    } else if (data.results.length > 0) {
      return SmartRefresher(
        enablePullUp: true,
        enablePullDown: true,
        controller: _refreshController,
        headerBuilder: WidgetsUtil.buildDefaultHeader,
        footerBuilder: WidgetsUtil.buildDefaultFooter,
        footerConfig: new RefreshConfig(),
        onRefresh: (up) {
          if (up) {
            _pullToRefresh();
          } else {
            _loadingMore();
          }
        },
        child: ListView(
          children: bulderDataView(list),
        ),
      );
    }
  }

  void getHistoryDate(int page, int pagesize, int type) async {
    data = null;

    String url = "${Api.DAY_HISTORY}/$pagesize/$page";
    var jsonData = await HttpUtil().get(url);

    debugPrint(jsonData.toString());

    data = BaseData.fromJson(jsonData);
    if (!data.error) {
      if (type == GlobalConfig.DEFAULT || type == GlobalConfig.REFRESH) {
        list.clear();
      }
      for (int i = 0; i < data.results.length; i++) {
        var _value = data.results[i];
        list.add(PostData.fromJson(_value));
      }
    }

    debugPrint(list.toString());

    if (type == GlobalConfig.LOAD_MORE) {
      _refreshController.sendBack(false, RefreshStatus.idle);
    } else if (type == GlobalConfig.REFRESH) {
      _refreshController.sendBack(true, RefreshStatus.completed);
    }

    setState(() {});
  }

  Future<Null> _pullToRefresh() async {
    page = 1;
    getHistoryDate(page, pagesize, GlobalConfig.REFRESH);
    return null;
  }

  Future<Null> _loadingMore() async {
    page++;
    getHistoryDate(page, pagesize, GlobalConfig.LOAD_MORE);
    return null;
  }

  List<Widget> bulderDataView(List<PostData> list) {
    List<Widget> widgets = [];

    for (int i = 0; i < list.length; i++) {
      widgets.add(InkWell(
        child: Card(
          margin: EdgeInsets.all(2.0),
          child: Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                height: 150.0,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: FadeInImage.assetNetwork(
                          placeholder: 'images/bg.jpg',
                          image: list[i].url,
                          fit: BoxFit.cover),
                    ),
                    Positioned(
                      bottom: 6.0,
                      left: 6.0,
                      right: 6.0,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          list[i].desc,
                          style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.w600,color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
        onTap: () {
          RouteUtil.routePagerNavigator(
              context, HistoryDataPage(date: list[i].desc));
        },
      ));
    }

    return widgets;
  }
}
