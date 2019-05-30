import 'package:flutter/material.dart';
import 'package:untitled4/model/common_model.dart';
import 'package:untitled4/util/navigator_util.dart';
import 'package:untitled4/widget/webview.dart';

class LocalNav extends StatelessWidget {
  final List<CommonModel> localNavList;

  const LocalNav({Key key, this.localNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (localNavList == null) return null;
    List<Widget> items = [];
    localNavList.forEach((i) {
      items.add(_item(i, context));
    });
    return Container(
      child: Padding(
        padding: EdgeInsets.all(7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, //平分
          children: items,
        ),
      ),
    );
  }

  Widget _item(CommonModel model, context) {
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
      child: Column(
        children: <Widget>[
          Image.network(
            model.icon,
            fit: BoxFit.fill,
            width: 32,
            height: 32,
          ),
          Container(
            margin: EdgeInsets.only(top: 3),
            child: Text(
              model.title,
              style: TextStyle(fontSize: 12,),
            ),
          )
        ],
      ),
    );
  }
}
