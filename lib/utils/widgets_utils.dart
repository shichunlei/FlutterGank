import 'package:FlutterGank/pages/model/PostData.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:FlutterGank/common/GlobalConfig.dart';
import 'package:FlutterGank/pages/fuli/photo_view_page.dart';
import 'package:FlutterGank/utils/route_util.dart';
import 'package:FlutterGank/widgets/loading_dialog_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:FlutterGank/pages/model/MenuModel.dart';

class WidgetsUtil {
  ///异常处理
  static Widget buildExceptionIndicator(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Image.asset(
                'images/empty_data.png',
                width: 50.0,
                height: 50.0,
                color: Colors.grey,
              ),
              Container(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  /// 正在加载
  static Widget buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  static buildLoadingDialog(BuildContext context, String text) {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          /// 调用对话框
          return LoadingDialogWidget(text: text);
        });
  }

  static Widget buildGridView(BuildContext context, List<PostData> list) {
    return GridView.builder(
      padding: EdgeInsets.all(6.0),

      /// 网格代理对象，一般使用SliverGridDelegateWithFixedCrossAxisCount对象创建，可指定crossAxisCount、mainAxisSpacing、crossAxisSpacing和childAspectRatio等值。
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        /// 表示垂直于主轴方向上的单元格Widget数量。如果scrollDirection为Axis.vertical，则表示水平单元格的数量；如果scrollDirection为Axis.horizontal，则表示垂直单元格的数量。
        crossAxisCount: 2,

        /// 表示主轴方向单元格的间距。
        mainAxisSpacing: 5.0,

        /// 表示垂直于主轴方向的单元格间距。
        crossAxisSpacing: 5.0,

        /// 表示单元格的宽高比。
        childAspectRatio: 1024 / 1319,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          //点击事件
          onTap: () => RouteUtil.routePagerNavigator(
              context, PhotoViewPage(item: list[index])),
          child: FadeInImage.assetNetwork(
              placeholder: 'images/bg.jpg',
              image: list[index].url,
              fit: BoxFit.cover),
        );
      },

      /// 表示网格的单元格总数。
      itemCount: list.length,
    );
  }

  static Widget buildListView(BuildContext context, List<PostData> list) {
    return ListView.builder(
      itemCount: list.length,
      scrollDirection: Axis.vertical,
      reverse: false,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              RouteUtil.routeWebView(
                  context, list[index].desc, list[index].url);
            },
            child: Card(
                margin: EdgeInsets.all(2.0),
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(children: <Widget>[
                      Row(children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 4.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(Icons.access_time,
                                    size: 12.0,
                                    color: GlobalConfig.colorPrimary))),
                        Text(
                          DateUtil.formatDateTime(list[index].publishedAt,
                              DateFormat.YEAR_MONTH_DAY, null, null),
                          style: TextStyle(fontSize: 12.0, color: Colors.grey),
                        ),
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(DateUtil.formatDateTime(
                              list[index].publishedAt,
                              DateFormat.YEAR_MONTH_DAY,
                              null,
                              null)),
                        ))
                      ]),
                      Container(
                          margin: EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 14.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(list[index].desc,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black)))),
                      Row(children: [
                        Text('作者:',
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.grey)),
                        Text(list[index].who,
                            style: TextStyle(
                                fontSize: 12.0,
                                color: GlobalConfig.colorPrimary)),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(list[index].source,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.grey))))
                      ])
                    ]))));
      },
    );
  }

  /// 图片ITEM布局
  static Widget buildImageItem(context, value) {
    return InkWell(
      child: Card(
        margin: EdgeInsets.all(2.0),
        child: Padding(
            padding: EdgeInsets.all(2.0),
            child: SizedBox(
              height: 300.0,
              child: FadeInImage.assetNetwork(
                  placeholder: 'images/bg.jpg',
                  image: value.url,
                  fit: BoxFit.cover),
            )),
      ),
      onTap: () {
        RouteUtil.routePagerNavigator(context, PhotoViewPage(item: value));
      },
    );
  }

  /// 内容ITEM布局
  static Widget buildListItem(context, value) {
    return InkWell(
        onTap: () {
          RouteUtil.routeWebView(context, value.desc, value.url);
        },
        child: Card(
            margin: EdgeInsets.all(2.0),
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(children: <Widget>[
                  Row(children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 4.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.access_time,
                                size: 12.0, color: GlobalConfig.colorPrimary))),
                    Text(
                      DateUtil.formatDateTime(value.publishedAt,
                          DateFormat.YEAR_MONTH_DAY, null, null),
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(DateUtil.formatDateTime(value.publishedAt,
                          DateFormat.YEAR_MONTH_DAY, null, null)),
                    ))
                  ]),
                  Container(
                      margin: EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 14.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(value.desc,
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.black)))),
                  Row(children: [
                    Text('作者:',
                        style: TextStyle(fontSize: 12.0, color: Colors.grey)),
                    Text(value.who,
                        style: TextStyle(
                            fontSize: 12.0, color: GlobalConfig.colorPrimary)),
                    Expanded(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(value.source,
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.grey))))
                  ])
                ]))));
  }

  /// 内容ITEM布局
  static Widget buildSearchListItem(context, value) {
    return InkWell(
        onTap: () {
          RouteUtil.routeWebView(context, value.desc, value.url);
        },
        child: Card(
            margin: EdgeInsets.all(2.0),
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      DateUtil.formatDateTime(value.publishedAt,
                          DateFormat.YEAR_MONTH_DAY, null, null),
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 14.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(value.desc,
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.black)))),
                  Row(children: [
                    Text('作者:',
                        style: TextStyle(fontSize: 12.0, color: Colors.grey)),
                    Text(value.who,
                        style: TextStyle(
                            fontSize: 12.0, color: GlobalConfig.colorPrimary)),
                  ])
                ]))));
  }

  static Widget buildDefaultHeader(BuildContext context, int mode) {
    return new ClassicIndicator(
      failedText: '刷新失败!',
      completeText: '刷新完成!',
      releaseText: '释放可以刷新',
      idleText: '下拉刷新哦!',
      failedIcon: new Icon(Icons.clear, color: GlobalConfig.colorPrimary),
      completeIcon:
          new Icon(Icons.forward_30, color: GlobalConfig.colorPrimary),
      idleIcon:
          new Icon(Icons.arrow_downward, color: GlobalConfig.colorPrimary),
      releaseIcon:
          new Icon(Icons.arrow_upward, color: GlobalConfig.colorPrimary),
      refreshingText: '正在刷新...',
      textStyle: new TextStyle(inherit: true, color: GlobalConfig.colorPrimary),
      mode: mode,
      refreshingIcon: const CircularProgressIndicator(
        strokeWidth: 3.0,
        valueColor: AlwaysStoppedAnimation(Colors.red),
      ),
    );
  }

  static Widget buildDefaultFooter(BuildContext context, int mode,
      [Function requestLoad]) {
    if (mode == RefreshStatus.failed || mode == RefreshStatus.idle) {
      return new InkWell(
        child: new ClassicIndicator(
          mode: mode,
          idleIcon:
              new Icon(Icons.arrow_upward, color: GlobalConfig.colorPrimary),
          textStyle:
              new TextStyle(inherit: true, color: GlobalConfig.colorPrimary),
          releaseIcon:
              new Icon(Icons.arrow_upward, color: GlobalConfig.colorPrimary),
          refreshingText: '火热加载中...',
          idleText: '上拉加载',
          failedText: '网络异常',
          releaseText: '释放可以加载',
          noDataText: '没有更多数据',
          refreshingIcon: const CircularProgressIndicator(
            strokeWidth: 3.0,
            valueColor: AlwaysStoppedAnimation(Colors.red),
          ),
        ),
        onTap: requestLoad,
      );
    } else
      return new ClassicIndicator(
          mode: mode,
          idleIcon:
              new Icon(Icons.arrow_upward, color: GlobalConfig.colorPrimary),
          textStyle:
              new TextStyle(inherit: true, color: GlobalConfig.colorPrimary),
          releaseIcon:
              new Icon(Icons.arrow_upward, color: GlobalConfig.colorPrimary),
          refreshingText: '火热加载中...',
          idleText: '上拉加载',
          failedText: '网络异常',
          releaseText: '释放可以加载',
          refreshingIcon: const CircularProgressIndicator(
            strokeWidth: 3.0,
            valueColor: AlwaysStoppedAnimation(Colors.red),
          ),
          noDataText: '没有更多数据');
  }

  static Widget buildMineLineWidget(color, width, height) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            border: BorderDirectional(
                start: BorderSide(color: color, width: width))));
  }

  static Widget buildVersionWidget(context, number, title, url) {
    return Container(
        width: (MediaQuery.of(context).size.width - 6.0) / 4,
        child: FlatButton(
            onPressed: () => RouteUtil.routeWebView(context, title, url),
            child: Container(
                height: 50.0,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          child: Text(title,
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: GlobalConfig.fontColor))),
                      Container(
                          child: Text(number,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: GlobalConfig.fontColor)))
                    ]))));
  }

  static buildShareBottomPop(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: 120.0,
              color: Colors.white,
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                padding: const EdgeInsets.all(4.0),
                children: menus_share.map((Menu m) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                            padding:
                                const EdgeInsets.only(top: 12.0, bottom: 12.0),
                            child: Image.asset(
                              m.icon,
                              width: 40.0,
                              height: 40.0,
                            )),
                        Text(m.title),
                      ],
                    ),
                  );
                }).toList(),
              ));
        });
  }

  static List<Widget> bulderDataView(context, String key, data) {
    List<Widget> widgets = [];

    if (key == "福利") {
      data.results.forEach((_key, _value) {
        if (key == _key) {
          for (int i = 0; i < _value.length; i++) {
            PostData item = PostData.fromJson(_value[i]);
            widgets.add(WidgetsUtil.buildImageItem(context, item));
          }
        }
      });
    } else {
      data.results.forEach((_key, _value) {
        if (key == _key) {
          for (int i = 0; i < _value.length; i++) {
            PostData item = PostData.fromJson(_value[i]);
            widgets.add(WidgetsUtil.buildListItem(context, item));
          }
        }
      });
    }

    return widgets;
  }

  static Widget buildTitleWidget(index, data) {
    return Container(
      color: Colors.grey,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20.0),
      child: Text(
        data.category[index].toString(),
        style: TextStyle(color: Colors.white),
      ),
      height: 40.0,
    );
  }
}
