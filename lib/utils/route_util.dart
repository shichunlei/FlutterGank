import 'package:flutter/material.dart';
import 'package:FlutterGank/pages/login/LoginPage.dart';
import 'package:FlutterGank/pages/detail/ArticleDetailPage.dart';
import 'package:FlutterGank/pages/detail/DetailPage.dart';

class RouteUtil {
  static routeWebView(BuildContext context, String title, String url) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return ArticleDetailPage(title: title, url: url);
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return FadeTransition(
            opacity: animation,
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
              child: child,
            ),
          );
        }));
  }

  static routePagerNavigator(BuildContext context, Widget widgetPage) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return widgetPage;
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return FadeTransition(
            opacity: animation,
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
              child: child,
            ),
          );
        }));
  }
}
