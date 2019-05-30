import 'package:flutter/material.dart';
import 'package:untitled4/model/common_model.dart';
import 'package:untitled4/util/navigator_util.dart';
import 'package:untitled4/widget/webview.dart';

class SubNav extends StatelessWidget {
  final List<CommonModel> subNavList;

  const SubNav({Key key, this.subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (subNavList == null) return null;
    int rowCount = (subNavList.length / 2 + 0.5).toInt();
    List<Widget> items = [];
    subNavList.forEach((f) {
      items.add(_item(context,f));
    });
    return Container(
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: items.sublist(0, rowCount),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: items.sublist(rowCount, items.length),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          )
        ],
      ),
    );
  }

  Widget _item(BuildContext context,CommonModel model) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: (){
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
              width: 18,
              height: 18,
              fit: BoxFit.fill,
            ),
            Container(
              padding: EdgeInsets.only(top: 3),
              child: Text(
                model.title,
                style: TextStyle(fontSize: 12),
              ),
            )
          ],
        ),
      )
    );
  }
}
