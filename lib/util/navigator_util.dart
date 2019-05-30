import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigatorUtil {
  ///跳转到指定页面
  static push(BuildContext context, Widget page) {
//    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    Navigator.push(context, new PageRouteBuilder(pageBuilder: (BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation) {
      // 跳转的路由对象
      return page;
    }, transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) {
      return createTransition(animation, child);
    }));
  }
  ///跳转动画
  static SlideTransition createTransition(
      Animation<double> animation, Widget child) {
    return new SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child,
    );
  }
}
