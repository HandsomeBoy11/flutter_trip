import 'package:flutter/material.dart';
import 'package:untitled4/model/common_model.dart';
import 'package:untitled4/model/grid_navItem_model.dart';
import 'package:untitled4/model/grid_nav_model.dart';
import 'package:untitled4/util/navigator_util.dart';
import 'package:untitled4/widget/webview.dart';

class GridNav extends StatelessWidget {
  final GridNavModel gridNavModel;

  const GridNav({Key key, this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: const Color(0x00000000),
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        child: Column(
          children: _getGridItems(context),
        ),
      ),
    );
  }

  _getGridItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNavModel == null) return items;
    if (gridNavModel.flight != null) {
      items.add(_rowItems(context, gridNavModel.flight, true));
    }
    if (gridNavModel.travel != null) {
      items.add(_rowItems(context, gridNavModel.travel, false));
    }
    if (gridNavModel.hotel != null) {
      items.add(_rowItems(context, gridNavModel.hotel, false));
    }
    return items;
  }

  Widget _rowItems(
      BuildContext context, GridNavItem gridNavItem, bool isFirst) {
    List<Widget> rowList = [];
    List<Widget> expandList = [];
    rowList.add(_mainItem(context, gridNavItem.mainItem));
    rowList.add(_doubleItem(context, gridNavItem.item1, gridNavItem.item2));
    rowList.add(_doubleItem(context, gridNavItem.item3, gridNavItem.item4));
    rowList.forEach((f) {
      expandList.add(Expanded(child: f));
    });
    Color startColor = Color(int.parse('0xff' + gridNavItem.startColor));
    Color endColor = Color(int.parse('0xff' + gridNavItem.endColor));
    BorderSide borderSide = BorderSide(color: Colors.white, width: 1);
    return Container(
      decoration: BoxDecoration(
          border: Border(top: isFirst ? BorderSide.none : borderSide),
          gradient: LinearGradient(colors: [startColor, endColor])),
      height: 88,
      child: Row(
        children: expandList,
      ),
    );
  }

  Widget _mainItem(BuildContext context, CommonModel model) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.push(
            context,
            WebView(
                url: model.url,
                statusBarColor: model.statusBarColor,
                title: model.title,
                hideAppBar: model.hideAppBar,
                backForbid: false));
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Image.network(
            model.icon,
            fit: BoxFit.contain,
            height: 88,
            width: 121,
            alignment: AlignmentDirectional.bottomEnd,
          ),
          Container(
            margin: EdgeInsets.only(top: 11),
            child: Text(model.title),
          )
        ],
      ),
    );
  }

  Widget _doubleItem(
      BuildContext context, CommonModel item1, CommonModel item2) {
    List<Widget> subList = [];
    subList.add(_subItem(context, item1, true));
    subList.add(_subItem(context, item2, false));
    return Column(
      children: subList,
    );
  }

  Widget _subItem(BuildContext context, CommonModel model, bool isFirst) {
    BorderSide borderSide = BorderSide(color: Colors.white, width: 1);
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            NavigatorUtil.push(
                context,
                WebView(
                    url: model.url,
                    statusBarColor: model.statusBarColor,
                    title: model.title,
                    hideAppBar: model.hideAppBar,
                    backForbid: false));
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    left: borderSide,
                    bottom: isFirst ? borderSide : BorderSide.none)),
            child: Center(
              child: Text(model.title),
            ),
          ),
        ));
  }
}
