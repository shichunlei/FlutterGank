import 'package:FlutterGank/common/GlobalConfig.dart';
import 'package:FlutterGank/http/api.dart';
import 'package:FlutterGank/pages/detail/DetailPage.dart';
import 'package:FlutterGank/pages/model/BaseResult.dart';
import 'package:FlutterGank/pages/model/XiaoduData.dart';
import 'package:FlutterGank/utils/http_util.dart';
import 'package:FlutterGank/utils/route_util.dart';
import 'package:FlutterGank/utils/toast_util.dart';
import 'package:FlutterGank/utils/widgets_utils.dart';
import 'package:FlutterGank/widgets/loading_dialog_widget.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class XianduTabPage extends StatefulWidget {
  String id;

  XianduTabPage({Key key, @required this.id}) : super(key: key);

  @override
  _XianduTabPageState createState() => _XianduTabPageState();
}

class _XianduTabPageState extends State<XianduTabPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  RefreshController _refreshController;

  int page = 1;
  int pagesize = 20;

  var requestError = false;

  BaseData data;
  List<XianduData> list = [];

  void enterRefresh() {
    _refreshController.requestRefresh(true);
  }

  @override
  void initState() {
    super.initState();
    _refreshController = new RefreshController();
    getListData(widget.id, page, pagesize, GlobalConfig.DEFAULT);
  }

  @override
  Widget build(BuildContext context) {
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
        child: _buildListview(context, list),
      );
    }
  }

  void getListData(String id, int page, int pagesize, int type) async {
    data = null;

    String url = "${Api.XIANDU}id/$id/count/$pagesize/page/$page";
    var jsonData = await HttpUtil().get(url);

    debugPrint(jsonData.toString());

    data = BaseData.fromJson(jsonData);
    if (!data.error) {
      if (type == GlobalConfig.DEFAULT || type == GlobalConfig.REFRESH) {
        list.clear();
      }
      for (int i = 0; i < data.results.length; i++) {
        var _value = data.results[i];
        list.add(XianduData.fromJson(_value));
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
    getListData(widget.id, page, pagesize, GlobalConfig.REFRESH);
    return null;
  }

  Future<Null> _loadingMore() async {
    page++;
    getListData(widget.id, page, pagesize, GlobalConfig.LOAD_MORE);
    return null;
  }

  Widget _buildListview(BuildContext context, List<XianduData> list) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          child: Card(
              margin: EdgeInsets.all(2.0),
              child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(children: <Widget>[
                    Expanded(
                      child: Column(children: <Widget>[
                        Row(children: <Widget>[
                          Expanded(child: SizedBox()),
                          Container(
                              margin: EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 4.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(Icons.access_time,
                                      size: 12.0,
                                      color: GlobalConfig.colorPrimary))),
                          Text(
                            DateUtil.formatDateTime(list[index].created_at,
                                DateFormat.YEAR_MONTH_DAY, null, null),
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.grey),
                          ),
                        ]),
                        Container(
                            margin: EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 14.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(list[index].title,
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.black)))),
                      ]),
                    ),
                    SizedBox(width: 10.0),
                    SizedBox(
                        height: 80.0,
                        width: 100.0,
                        child: FadeInImage.assetNetwork(
                            placeholder: 'images/bg.jpg',
                            image: list[index].cover.toString(),
                            fit: BoxFit.cover))
                  ]))),
          onTap: () {
            debugPrint(list[index].content);
            if (list[index].content.isEmpty) {
              RouteUtil.routeWebView(
                  context, list[index].title, list[index].url);
            } else {
              RouteUtil.routePagerNavigator(
                  context,
                  DetailPage(
                      title: list[index].title,
                      content: list[index].content.toString()));
            }
          },
        );
      },
      itemCount: list.length,
    );
  }
}
