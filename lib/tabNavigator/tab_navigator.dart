import 'package:flutter/material.dart';
import 'package:untitled4/pages/home_page.dart';
import 'package:untitled4/pages/my_page.dart';
import 'package:untitled4/pages/search_page.dart';
import 'package:untitled4/pages/takePhoto_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final PageController _pageController = PageController();
  var _currentIndex = 0;
  final nomalColor = Colors.grey;
  final activityColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[HomePage(), SearchPage(), TakePhotoPage(), MyPage()],
        onPageChanged: (index){
          _currentIndex=index;
          setState(() {
            _getItemBar(index);
          });

        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          _getItemBar(0),
          _getItemBar(1),
          _getItemBar(2),
          _getItemBar(3),
        ],
        onTap: (index) {
          _currentIndex = index;
          _pageController.jumpToPage(_currentIndex);
        },
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  ///获取tabbar条目
  _getItemBar(index) {
    String tabName = '首页';
    var icon = Icons.home;
    switch (index) {
      case 0:
        tabName = '首页';
        icon = Icons.home;
        break;
      case 1:
        tabName = '搜索';
        icon = Icons.search;
        break;
      case 2:
        tabName = '旅拍';
        icon = Icons.camera_alt;
        break;
      case 3:
        tabName = '我的';
        icon = Icons.person;
        break;
    }
    return BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: Icon(icon),
      title: Text(
        tabName,
        style: TextStyle(
            color: _currentIndex == index ? activityColor : nomalColor),
      ),
    );
  }


}
