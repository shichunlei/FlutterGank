import 'package:FlutterGank/pages/fuli/FuliPage.dart';
import 'package:flutter/material.dart';
import 'package:FlutterGank/common/GlobalConfig.dart';
import 'package:FlutterGank/pages/about/AboutUsPage.dart';
import 'package:FlutterGank/pages/classify/ClassifyPage.dart';
import 'package:FlutterGank/pages/history/HistoryPage.dart';
import 'package:FlutterGank/pages/home/HomePage.dart';
import 'package:FlutterGank/pages/mine/MinePage.dart';
import 'package:FlutterGank/pages/search/SearchPage.dart';
import 'package:FlutterGank/utils/route_util.dart';
import 'package:FlutterGank/utils/sp_util.dart';
import 'package:FlutterGank/utils/toast_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationPage extends StatefulWidget {
  @override
  createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage>
    with SingleTickerProviderStateMixin {
  bool isLogin = false;
  String username = "没有登录";
  String email = "";
  String avatarUrl = GlobalConfig.DEFAULT_AVATAR_URL;

  /// 选中页下标
  int _currentIndex = 0;

  /// 页面标题
  String title = GlobalConfig.homeTab;
  PageController _controller;

  /// 上次点击时间
  DateTime _lastPressedAt;

  bool isShowLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: this._currentIndex);

    _getLoginState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onBackPressed,
        child: Scaffold(

            /// 标题栏
            appBar: AppBar(title: Text(title), centerTitle: true),

            /// 左侧菜单
            drawer: Drawer(child: _bulderDrawMenu(), elevation: 10.0),

            /// 内容
            body: PageView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[HomePage(), ClassifyPage(), MinePage()],
                controller: _controller,
                onPageChanged: (index) => onPageChanged(index)),

            /// 底部栏
            bottomNavigationBar: BottomNavigationBar(
                items: _bottomTabs(),
                currentIndex: _currentIndex,
                onTap: (index) {
                  debugPrint("$index");
                  _controller.animateToPage(index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease);
                },
                fixedColor: GlobalConfig.colorPrimary,
                type: BottomNavigationBarType.fixed)));
  }

  void onPageChanged(int index) {
    setState(() {
      this._currentIndex = index;
      switch (_currentIndex) {
        case 0:
          title = GlobalConfig.homeTab;
          break;
        case 1:
          title = GlobalConfig.classyTab;
          break;
        case 2:
          title = GlobalConfig.mineTab;
          break;
      }
    });
  }

  List<BottomNavigationBarItem> _bottomTabs() {
    List<BottomNavigationBarItem> tags = [];

    tags
      ..add(BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          title: Text(GlobalConfig.homeTab),
          backgroundColor: GlobalConfig.colorPrimary))
      ..add(BottomNavigationBarItem(
          icon: Icon(
            Icons.tune,
          ),
          title: Text(GlobalConfig.classyTab),
          backgroundColor: GlobalConfig.colorPrimary))
      ..add(BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
          ),
          title: Text(GlobalConfig.mineTab),
          backgroundColor: GlobalConfig.colorPrimary));

    return tags;
  }

  /// 监听返回键，点击两下退出程序
  Future<bool> onBackPressed() async {
    if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt) > Duration(seconds: 2)) {
      //两次点击间隔超过2秒则重新计时
      _lastPressedAt = DateTime.now();
      ToastUtil.show("再按一次退出", context,
          duration: ToastUtil.LENGTH_SHORT, gravity: ToastUtil.BOTTOM);
      return false;
    }
    return true;
  }

  /// 左侧菜单栏
  Widget _bulderDrawMenu() {
    return ListView(children: <Widget>[
      UserAccountsDrawerHeader(
        /// 姓名
        accountName: Text(username),

        /// 邮箱
        accountEmail: Text(email),

        /// 用户头像
        currentAccountPicture: InkWell(
          child: CircleAvatar(
            backgroundImage: NetworkImage(avatarUrl),
          ),
          onTap: () {
            Navigator.pop(context);
            RouteUtil.routePagerNavigator(context, AboutUsPage());
          },
        ),

        /// 装饰器
        decoration: BoxDecoration(
          color: Colors.grey,
          image: DecorationImage(
              image: NetworkImage(GlobalConfig.MENU_TOP_BACKGROUND_URL),
              //image: ExactAssetImage("images/flutter.png"),
              fit: BoxFit.fill),
        ),
      ),
      ListTile(
          title: Text("福利"),
          leading: Icon(Icons.whatshot),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            debugPrint("Home");
            Navigator.of(context).pop();
            RouteUtil.routePagerNavigator(context, FuliPage(title: "福利"));
          }),
      Divider(),
      ListTile(
          title: Text("搜索"),
          leading: Icon(Icons.search),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context).pop();
            RouteUtil.routePagerNavigator(context, SearchPage());
          }),
      Divider(),
      ListTile(
          title: Text("历史"),
          leading: Icon(Icons.history),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            debugPrint("Notification");
            Navigator.of(context).pop();
            RouteUtil.routePagerNavigator(context, HistoryPage());
          }),
      Divider(),
      ListTile(
          title: Text("Exit"),
          leading: Icon(Icons.exit_to_app),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context).pop();
            _buildAlertDailog(context);
          }),
      Divider()
    ]);
  }

  _buildAlertDailog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('提示'),
            //标题
            titlePadding: EdgeInsets.all(20),
            //标题的padding值
            content: Text('是否退出账号'),
            //弹框展示主要内容
            contentPadding: EdgeInsets.only(left: 20, right: 20),
            //内容的padding值
            actions: <Widget>[
              //操作按钮数组
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('取消'),
              ),
              FlatButton(
                onPressed: () {
                  SPUtil.saveBool("is_login", false);
                  _getLoginState();
                  Navigator.pop(context);
                },
                child: Text('确定'),
              ),
            ],
          );
        });
  }

  _getLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool("is_login");

    getLoginData();
    setState(() {});
  }

  getLoginData() {
    if (isLogin) {
      username = GlobalConfig.USER_NAME;
      avatarUrl = GlobalConfig.AVATAR_URL;
      email = GlobalConfig.EMAIL;
    } else {
      username = "没有登录";
      avatarUrl = GlobalConfig.DEFAULT_AVATAR_URL;
      email = "";
    }
  }
}
