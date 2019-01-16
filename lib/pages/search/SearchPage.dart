import 'package:flutter/material.dart';
import 'package:FlutterGank/common/GlobalConfig.dart';
import 'package:FlutterGank/http/api.dart';
import 'package:FlutterGank/pages/model/BaseResult.dart';
import 'package:FlutterGank/pages/model/SearchData.dart';
import 'package:FlutterGank/utils/http_util.dart';
import 'package:FlutterGank/utils/toast_util.dart';
import 'package:FlutterGank/utils/widgets_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller;

  String query = "";

  RefreshController _refreshController;

  int page = 1;
  int pagesize = 30;

  var requestError = false;
  bool isShowLoading = false;

  BaseData data;
  List<SearchData> list = [];

  void enterRefresh() {
    _refreshController.requestRefresh(true);
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _refreshController = new RefreshController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var searchField = Container(
      color: Colors.white70,
      child: TextField(
        autofocus: true,
        textInputAction: TextInputAction.search,
        onSubmitted: (content) {
          changeContent();
        },
        cursorColor: Colors.white,
        cursorWidth: 1.0,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '请输入搜索关键词',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        controller: _controller,
        style: TextStyle(color: Colors.white),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: searchField,
        actions: <Widget>[
          IconButton(
              icon: new Icon(Icons.close),
              onPressed: () {
                setState(() {
                  query = "";
                  _controller.clear();
                });
              }),
        ],
      ),
      body: _buildSearchDateView(),
    );
  }

  void changeContent() {
    setState(() {
      query = _controller.text;
      debugPrint(query);

      if (query.isNotEmpty) {
        WidgetsUtil.buildLoadingDialog(context, "正在加载...");
        isShowLoading = true;
        searchData(query, page, pagesize, GlobalConfig.DEFAULT);
      } else {
        ToastUtil.show("请输入搜索关键词", context);
      }
    });
  }

  void searchData(String query, page, pagesize, int type) async {
    debugPrint("调用搜索接口");

    data = null;

    String url = "${Api.SEARCH}/$query/count/$pagesize/page/$page";
    var jsonData = await HttpUtil().get(url);

    data = BaseData.fromJson(jsonData);
    if (!data.error) {
      if (type == GlobalConfig.DEFAULT || type == GlobalConfig.REFRESH) {
        list.clear();
      }
      for (int i = 0; i < data.results.length; i++) {
        var _value = data.results[i];
        list.add(SearchData.fromJson(_value));
      }
    }

    debugPrint(list.toString());

    if (type == GlobalConfig.LOAD_MORE) {
      _refreshController.sendBack(false, RefreshStatus.idle);
    } else if (type == GlobalConfig.REFRESH) {
      _refreshController.sendBack(true, RefreshStatus.completed);
    }

    setState(() {});

    if (isShowLoading) {
      Navigator.of(context).pop();
      isShowLoading = false;
    }
  }

  Widget _buildSearchDateView() {
    if (data == null) {
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
          children: bulderDataView(query, list),
        ),
      );
    }
  }

  Future<Null> _pullToRefresh() async {
    page = 1;
    searchData(query, page, pagesize, GlobalConfig.REFRESH);
    return null;
  }

  Future<Null> _loadingMore() async {
    page++;
    searchData(query, page, pagesize, GlobalConfig.LOAD_MORE);
    return null;
  }

  List<Widget> bulderDataView(String key, List<SearchData> list) {
    List<Widget> widgets = [];

    for (int i = 0; i < list.length; i++) {
      widgets.add(WidgetsUtil.buildSearchListItem(context, list[i]));
    }

    return widgets;
  }
}
