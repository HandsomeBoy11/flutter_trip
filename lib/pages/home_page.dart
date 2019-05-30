import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:untitled4/dao/home_dao.dart';
import 'package:untitled4/model/common_model.dart';
import 'package:untitled4/model/grid_nav_model.dart';
import 'package:untitled4/model/home_model.dart';
import 'package:untitled4/model/salesBox_model.dart';
import 'package:untitled4/pages/search_page.dart';
import 'package:untitled4/util/navigator_util.dart';
import 'package:untitled4/widget/grid_nav.dart';
import 'package:untitled4/widget/loading_container.dart';
import 'package:untitled4/widget/local_nav.dart';
import 'package:untitled4/widget/sales_box.dart';
import 'package:untitled4/widget/search_bar.dart';
import 'package:untitled4/widget/sub_nav.dart';
import 'package:untitled4/widget/webview.dart';

const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  var maxHeight = 100.0;
  double opacity = 0;
  List<CommonModel> pics = [];
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  GridNavModel gridNav;
  SalesBoxModel salesBox;
  bool _isLoading = true;

  _onScroll(var offset) {
    double alpha = offset / maxHeight;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      opacity = alpha;
    });
  }

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoadingContainer(
            isLoading: _isLoading,
            child: Stack(
              children: <Widget>[
                MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: NotificationListener(
                        onNotification: (scrollNotification) {
                          if (scrollNotification is ScrollUpdateNotification &&
                              scrollNotification.depth == 0) {
                            //depth(深度)只控制子空间的第一个
                            _onScroll(scrollNotification.metrics.pixels);
                          }
                        },
                        child: RefreshIndicator(
                            child: _listView(), onRefresh: _handleRefresh))),
                _appBar()
              ],
            )));
  }

  Widget _bannerItem() {
    return Swiper(
      itemCount: pics.length,
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return Image.network(
          pics[index].icon,
          fit: BoxFit.fill,
        );
      },
      pagination: SwiperPagination(),
      onTap: (index) {
        var pic = pics[index];
        NavigatorUtil.push(
            context,
            WebView(
                url: pic.url,
                statusBarColor: pic.statusBarColor,
                title: pic.title,
                hideAppBar: pic.hideAppBar,
                backForbid: false));
      },
    );
  }

  Future<Null> _handleRefresh() async {
    try {
      HomeModel homeModel = await HomeDao.fetch();
      setState(() {
        _isLoading = false;
        pics = homeModel.bannerList;
        localNavList = homeModel.localNavList;
        gridNav = homeModel.gridNav;
        subNavList = homeModel.subNavList;
        salesBox = homeModel.salesBox;
      });
    } catch (e) {
      _isLoading = false;
      print('异常：$e');
    }
  }

  Widget _listView() {
    return ListView(
      children: <Widget>[
        Container(height: 160, child: _bannerItem()),
        LocalNav(
          localNavList: localNavList,
        ),
        Padding(
          padding: EdgeInsets.all(7),
          child: GridNav(
            gridNavModel: gridNav,
          ),
        ),
        SubNav(
          subNavList: subNavList,
        ),
        SalesBox(salesBox: salesBox)
      ],
    );
  }

  Widget _appBar() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
              height: 65,
              decoration: BoxDecoration(
                  color:
                      Color.fromARGB((opacity * 255).toInt(), 255, 255, 255)),
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: FractionallySizedBox(
                widthFactor: 1,
                child: SearchBar(
                  searchBarType: opacity > 0.2
                      ? SearchBarType.homeLight
                      : SearchBarType.home,
                  defaultText: SEARCH_BAR_DEFAULT_TEXT,
                    localCallBack:(){
                    },
                    inputBoxClick:(){
                    NavigatorUtil.push(context, SearchPage(hideLeft: false,));

                    },
                    rightButtonClick:(){

                    },
                ),
              )),
        ),
        Container(
          height: opacity > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
