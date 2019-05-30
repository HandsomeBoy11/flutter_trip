import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled4/tabNavigator/tab_navigator.dart';
import 'package:untitled4/test/GridViewDemo.dart';
import 'package:untitled4/test/ListViewDemo.dart';

void main() {
  // 强制竖屏
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabNavigator(),
//      home: GridViewDemo(),
    );
  }
}
