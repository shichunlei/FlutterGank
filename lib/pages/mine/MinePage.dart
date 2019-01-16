import 'package:FlutterGank/http/api.dart';
import 'package:FlutterGank/pages/model/BaseResult.dart';
import 'package:FlutterGank/pages/model/CategoryData.dart';
import 'package:FlutterGank/pages/xiandu/XianduPage.dart';
import 'package:FlutterGank/utils/http_util.dart';
import 'package:flutter/material.dart';
import 'package:FlutterGank/common/GlobalConfig.dart';
import 'package:FlutterGank/pages/login/LoginPage.dart';
import 'package:FlutterGank/utils/route_util.dart';
import 'package:FlutterGank/utils/widgets_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool _isLogin = false;
  String username = "没有登录";
  String avatarUrl = GlobalConfig.DEFAULT_AVATAR_URL;

  List<CategoryData> categorys = [];
  BaseData data;

  bool isShowLoading = false;

  @override
  void initState() {
    super.initState();

    _getCategoryData();
    _getLoginState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: _bulderBodyWidget(),
      onRefresh: _onRefresh,
    );
  }

  Future<void> _onRefresh() async {
    _getCategoryData();
    _getLoginState();
  }

  Widget _bulderBodyWidget() {
    return ListView(
      children: <Widget>[
        new Container(
          color: GlobalConfig.colorPrimary,
          child: FlatButton(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                    backgroundImage: NetworkImage(avatarUrl), radius: 50.0),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  username,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            onPressed: () {
              if (_isLogin) {
              } else {
                _routePagerNavigatorResult(context);
              }
            },
          ),
          height: 200.0,
        ),
        Container(
            color: GlobalConfig.cardBackgroundColor,
            margin: const EdgeInsets.only(bottom: 6.0),
            padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
            child: Column(children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    WidgetsUtil.buildVersionWidget(
                        context,
                        "185",
                        GlobalConfig.flutterVersion,
                        GlobalConfig.flutterGithubUrl),
                    WidgetsUtil.buildMineLineWidget(Colors.black12, 1.0, 14.0),
                    WidgetsUtil.buildVersionWidget(context, "15",
                        GlobalConfig.wxVersion, GlobalConfig.wxGithubUrl),
                    WidgetsUtil.buildMineLineWidget(Colors.black12, 1.0, 14.0),
                    WidgetsUtil.buildVersionWidget(
                        context,
                        "218",
                        GlobalConfig.androidVersion,
                        GlobalConfig.androidGithubUrl),
                    WidgetsUtil.buildMineLineWidget(Colors.black12, 1.0, 14.0),
                    WidgetsUtil.buildVersionWidget(context, "33",
                        GlobalConfig.iosVersion, GlobalConfig.iosGithubUrl)
                  ],
                ),
              ),
            ])),
        _buildGridWidget(categorys),
        _buildPushWidget(),
        _buildCardWidget(),
      ],
    );
  }

  Widget _buildGridWidget(List<CategoryData> categorys) {
    return GridView.builder(
      /// 表示网格的单元格总数。
      itemCount: categorys.length,
      primary: false,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        /// 表示垂直于主轴方向上的单元格Widget数量。如果scrollDirection为Axis.vertical，则表示水平单元格的数量；如果scrollDirection为Axis.horizontal，则表示垂直单元格的数量。
        crossAxisCount: 3,

        /// 表示主轴方向单元格的间距。
        mainAxisSpacing: 1.0,

        /// 表示垂直于主轴方向的单元格间距。
        crossAxisSpacing: 1.0,

        /// 表示单元格的宽高比。
        childAspectRatio: 4 / 3,
      ),
      itemBuilder: (context, index) {
        return Container(
          color: GlobalConfig.cardBackgroundColor,
          child: FlatButton(
              onPressed: () {
                WidgetsUtil.buildLoadingDialog(context, "正在加载...");
                isShowLoading = true;
                _getSubCategory(
                    categorys[index].en_name.toString(), categorys[index].name);
              },
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: CircleAvatar(
                        radius: 20.0,
                        child: Icon(GlobalConfig.ITEM_ICONS[index],
                            color: Colors.white),
                        backgroundColor:
                            GlobalConfig.ITEM_BACKGROUND_COLORS[index],
                      ),
                    ),
                    Container(
                      child: Text(categorys[index].name,
                          style: TextStyle(
                              color: GlobalConfig.fontColor, fontSize: 14.0)),
                    )
                  ],
                ),
              )),
        );
      },
      padding: const EdgeInsets.only(bottom: 6.0),
    );
  }

  Widget _buildPushWidget() {
    return GridView.builder(
      /// 表示网格的单元格总数。
      itemCount: GlobalConfig.ABOUT_TITLE.length,
      primary: false,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        /// 表示垂直于主轴方向上的单元格Widget数量。如果scrollDirection为Axis.vertical，则表示水平单元格的数量；如果scrollDirection为Axis.horizontal，则表示垂直单元格的数量。
        crossAxisCount: 4,

        /// 表示单元格的宽高比。
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        return Container(
          color: GlobalConfig.cardBackgroundColor,
          child: FlatButton(
              onPressed: () {
                RouteUtil.routeWebView(context, GlobalConfig.ABOUT_TITLE[index],
                    GlobalConfig.ABOUT_URL[index]);
              },
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: CircleAvatar(
                        radius: 20.0,
                        child: Icon(GlobalConfig.ABOUT_IMAGES[index],
                            color: Colors.white),
                        backgroundColor: GlobalConfig.ABOUT_COLOR[index],
                      ),
                    ),
                    Container(
                      child: Text(GlobalConfig.ABOUT_TITLE[index],
                          style: TextStyle(
                              color: GlobalConfig.fontColor, fontSize: 14.0)),
                    )
                  ],
                ),
              )),
        );
      },
      padding: const EdgeInsets.only(bottom: 6.0),
    );
  }

  Widget _buildCardWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: 6.0),
        color: GlobalConfig.cardBackgroundColor,
        padding: EdgeInsets.only(bottom: 10.0),
        child: Column(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(left: 16.0, right: 6.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: CircleAvatar(
                        radius: 20.0,
                        child: Icon(Icons.child_care, color: Colors.white),
                        backgroundColor: Color(0xFFB36905),
                      ),
                      width: 30.0,
                      height: 30.0,
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "妹子福利",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                    FlatButton(
                        onPressed: () {
                          debugPrint("更多");
                        },
                        child: Text(
                          "更多",
                          style: TextStyle(color: Colors.blue),
                        )),
                  ],
                )),
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    _buildVideoCardWidget(
                        "https://pic3.zhimg.com/50/v2-7fc9a1572c6fc72a3dea0b73a9be36e7_400x224.jpg",
                        null),
                    _buildVideoCardWidget(
                        "https://pic2.zhimg.com/50/v2-5942a51e6b834f10074f8d50be5bbd4d_400x224.jpg",
                        null),
                    _buildVideoCardWidget(
                        "https://pic4.zhimg.com/50/v2-898f43a488b606061c877ac2a471e221_400x224.jpg",
                        null),
                    _buildVideoCardWidget(
                        "https://pic1.zhimg.com/50/v2-0008057d1ad2bd813aea4fc247959e63_400x224.jpg",
                        null),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget _buildVideoCardWidget(image, id) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      margin: const EdgeInsets.only(right: 3.0, left: 3.0),
      child: AspectRatio(
        aspectRatio: 400.0 / 224.0,
        child: Container(
          foregroundDecoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image),
                centerSlice: Rect.fromLTRB(270.0, 180.0, 1360.0, 1730.0),
              ),
              borderRadius: const BorderRadius.all(const Radius.circular(6.0))),
        ),
      ),
    );
  }

  _getLoginData() {
    if (_isLogin) {
      username = GlobalConfig.USER_NAME;
      avatarUrl = GlobalConfig.AVATAR_URL;
    } else {
      username = "没有登录";
      avatarUrl = GlobalConfig.DEFAULT_AVATAR_URL;
    }
  }

  _routePagerNavigatorResult(BuildContext context) async {
    final result = await Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return LoginPage();
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return FadeTransition(
            opacity: animation,
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
              child: child,
            ),
          );
        },
      ),
    );

    debugPrint(result);
    setState(() {
      _getLoginState();
    });
  }

  void _getLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLogin = prefs.getBool("is_login");

    _getLoginData();
    setState(() {});
  }

  void _getCategoryData() async {
    String url = Api.CATEGORY;
    var jsonData = await HttpUtil().get(url);

    data = BaseData.fromJson(jsonData);
    debugPrint("=======");
    debugPrint(data.toString());

    if (!data.error) {
      categorys.clear();
      for (int i = 0; i < data.results.length; i++) {
        CategoryData item = CategoryData.fromJson(data.results[i]);
        categorys.add(item);
      }
    }

    setState(() {
      _buildGridWidget(categorys);
    });
  }

  void _getSubCategory(String subcategory, String title) async {
    String url = '${Api.SUB_CATEGORY}$subcategory';
    var jsonData = await HttpUtil().get(url);

    BaseData data = BaseData.fromJson(jsonData);
    debugPrint("=======");
    debugPrint(data.toString());

    if (!data.error) {
      if (isShowLoading) {
        Navigator.of(context).pop();
        isShowLoading = false;
      }
      List<SubCategory> categorys = [];
      for (int i = 0; i < data.results.length; i++) {
        SubCategory item = SubCategory.fromJson(data.results[i]);
        categorys.add(item);
      }

      RouteUtil.routePagerNavigator(
          context, XianduPage(title: title, categorys: categorys));
    }
  }
}
