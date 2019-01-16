import 'package:FlutterGank/http/api.dart';
import 'package:FlutterGank/pages/model/BaseResult.dart';
import 'package:FlutterGank/utils/http_util.dart';
import 'package:FlutterGank/utils/widgets_utils.dart';
import 'package:FlutterGank/widgets/loading_dialog_widget.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

class HistoryDataPage extends StatefulWidget {
  String date;

  HistoryDataPage({Key key, @required this.date}) : super(key: key);

  @override
  _HistoryDataPageState createState() => _HistoryDataPageState();
}

class _HistoryDataPageState extends State<HistoryDataPage> {
  BaseData2 data;

  @override
  void initState() {
    super.initState();
    getSelectDateData(widget.date);
    debugPrint(DateUtil.formatDateTime(
        widget.date, DateFormat.YEAR_MONTH_DAY, "/", null));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.date),
      ),
      body: RefreshIndicator(
        child: bulderBodyWidget(),
        onRefresh: _pullToRefresh,
      ),
    );
  }

  void getSelectDateData(String date) async {
    String _date = DateUtil.formatDateTime(
        widget.date, DateFormat.YEAR_MONTH_DAY, "/", null);
    String url = "${Api.HISTORY}/$_date";
    var jsonData = await HttpUtil().get(url);

    data = BaseData2.fromJson(jsonData);
    debugPrint("=======");
    debugPrint(data.toString());

    setState(() {});
  }

  Widget bulderBodyWidget() {
    if (data == null) {
      return LoadingDialogWidget(text: '正在加载...');
    } else if (data.error) {
      return WidgetsUtil.buildExceptionIndicator("网络请求错误");
    } else if (data.results.length == 0) {
      return WidgetsUtil.buildExceptionIndicator("这里空空的什么都没有呢...");
    } else {
      return ListView(
        children: bulderDailyListView(),
      );
    }
  }

  Future<void> _pullToRefresh() {
    getSelectDateData(widget.date);
  }

  List<Widget> bulderDailyListView() {
    List<Widget> widgets = [];
    for (int i = 0; i < data.category.length; i++) {
      debugPrint(data.category[i]);
      widgets
        ..add(WidgetsUtil.buildTitleWidget(i, data))
        ..addAll(WidgetsUtil.bulderDataView(context, data.category[i], data));
    }

    return widgets;
  }
}
