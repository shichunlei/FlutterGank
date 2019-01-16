import 'package:flutter/material.dart';

/// 全局配置
class GlobalConfig {
  /// 颜色值
  static Color colorPrimary = Colors.red;
  static Color searchBackgroundColor = Color(0xFFEBEBEB);
  static Color cardBackgroundColor = Colors.white;
  static Color fontColor = Colors.black54;
  static Color backgroundColor = Color(0xFFEBEBEB);

  /// 导航
  static String homeTab = "首页";
  static String classyTab = "分类";
  static String mineTab = "我的";

  ///
  static String BASE_URL = "http://gank.io/api/";

  /// 菜单栏用户信息
  static String USER_NAME = "SCL";
  static String EMAIL = "1558053958@qq.com";
  static String AVATAR_URL =
      "http://img4.duitang.com/uploads/item/201305/15/20130515204443_cSZzP.thumb.700_0.png";
  static String MENU_TOP_BACKGROUND_URL =
      "http://pic33.photophoto.cn/20141028/0038038006886895_b.jpg";

  /// 未登录信息
  static String DEFAULT_AVATAR_URL =
      "https://pic1.zhimg.com/v2-ec7ed574da66e1b495fcad2cc3d71cb9_xl.jpg";

  /// 分类
  static List CLASSIFY_TITLES = [
    "all",
    "Android",
    "iOS",
    "休息视频",
    "拓展资源",
    "前端",
    "瞎推荐",
    "App",
  ];

  static List ITEM_ICONS = [
    Icons.layers,
    Icons.games,
    Icons.watch,
    Icons.wrap_text,
    Icons.tablet_android,
    Icons.text_format,
    Icons.movie,
    Icons.tv,
    Icons.favorite
  ];

  static List ITEM_BACKGROUND_COLORS = [
    Colors.deepPurple,
    Colors.green,
    Colors.blue,
    Colors.pink,
    Colors.limeAccent,
    Colors.cyan,
    Colors.brown,
    Colors.orange,
    Colors.red
  ];

  /// 数据加载形式
  static int DEFAULT = 0x1000;
  static int LOAD_MORE = 0x2000;
  static int REFRESH = 0x3000;

  /// gank-io 不同语言版本
  static String flutterVersion = "Flutter版";
  static String wxVersion = "小程序版";
  static String androidVersion = "Android版";
  static String iosVersion = "iOS版";

  ///URL链接
  static String wxGithubUrl = "https://github.com/ZQ330093887/GankWX";
  static String flutterGithubUrl = "https://github.com/ZQ330093887/GankFlutter";
  static String iosGithubUrl = "https://github.com/ZQ330093887/GankIOSProgect";
  static String androidGithubUrl =
      "https://github.com/ZQ330093887/ConurbationsAndroid";

  static List ABOUT_IMAGES = [
    Icons.invert_colors,
    Icons.edit,
    Icons.update,
    Icons.perm_data_setting
  ];
  static List ABOUT_COLOR = [
    Color(0xFFB88800),
    Color(0xFF63616D),
    Color(0xFFB86A0D),
    Color(0xFF636269)
  ];
  static List ABOUT_TITLE = ['干货推荐', '感谢编辑', '版本更新', '关于作者'];
  static List ABOUT_URL = [
    'https://gank.io/',
    'https://gank.io/backbone',
    'https://github.com/shichunlei/FlutterGank',
    'https://github.com/shichunlei'
  ];

  ///登录
  static String githubLogin = "Github 账号登录";
  static String pwdLogin = "密码登录";
  static String loginSubView = "登  录";
  static String pwd = "密码";
  static String nice = "账号";
  static String inputCode = "请输入短信验证码";
  static String inputNice = "请输入用户名/邮箱地址";
}
