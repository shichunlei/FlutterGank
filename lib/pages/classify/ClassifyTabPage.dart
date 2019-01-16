import 'package:flutter/material.dart';
import 'package:FlutterGank/common/GlobalConfig.dart';
import 'package:FlutterGank/http/api.dart';
import 'package:FlutterGank/pages/model/BaseResult.dart';
import 'package:FlutterGank/pages/model/PostData.dart';
import 'package:FlutterGank/utils/http_util.dart';
import 'package:FlutterGank/utils/toast_util.dart';
import 'package:FlutterGank/utils/widgets_utils.dart';
import 'package:FlutterGank/widgets/loading_dialog_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ClassifyTabPage extends StatefulWidget {
  String title;

  ClassifyTabPage({Key key, @required this.title}) : super(key: key);

  @override
  _ClassifyTabPageState createState() => _ClassifyTabPageState();
}

class _ClassifyTabPageState extends State<ClassifyTabPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

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
    getListData(widget.title, page, pagesize, GlobalConfig.DEFAULT);
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
        child: WidgetsUtil.buildListView(context, list),
      );
    }
  }

  void getListData(String title, int page, int pagesize, int type) async {
    data = null;

    String url = "${Api.DATA}/$title/$pagesize/$page";
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
    getListData(widget.title, page, pagesize, GlobalConfig.REFRESH);
    return null;
  }

  Future<Null> _loadingMore() async {
    page++;
    getListData(widget.title, page, pagesize, GlobalConfig.LOAD_MORE);
    return null;
  }
}
