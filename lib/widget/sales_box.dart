import 'package:flutter/material.dart';
import 'package:untitled4/model/common_model.dart';
import 'package:untitled4/model/salesBox_model.dart';
import 'package:untitled4/util/navigator_util.dart';
import 'package:untitled4/widget/webview.dart';

class SalesBox extends StatelessWidget {
  final SalesBoxModel salesBox;

  const SalesBox({Key key, this.salesBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderSide topBorder = BorderSide(
      color: const Color(0x11111111),
      width: 10,
    );
    BorderSide bottomBorder = BorderSide(
      color: const Color(0x11111111),
      width: 1,
    );
if(salesBox==null) return Container();
    List<CommonModel> itemList = [];
//    List<Widget> widgetList=[];
    itemList.add(salesBox.bigCard1);
    itemList.add(salesBox.bigCard2);
    itemList.add(salesBox.smallCard1);
    itemList.add(salesBox.smallCard2);
    itemList.add(salesBox.smallCard3);
    itemList.add(salesBox.smallCard4);

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 7, right: 7),
          height: 44,
          decoration: BoxDecoration(
              border: Border(top: topBorder, bottom: bottomBorder)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.network(
                salesBox.icon,
                height: 15,
                fit: BoxFit.fill,
              ),
              GestureDetector(
                onTap: () {
                  NavigatorUtil.push(
                      context,
                      WebView(
                          url: salesBox.moreUrl,
                          title: '更多福利',
                          backForbid: false));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: LinearGradient(
                          colors: [
                            Color(0xffff4e63),
                            Color(0xffff6cc9),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight)),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 7, right: 7, top: 3, bottom: 3),
                    child: Text(
                      '获取更多福利 >',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(left: 7,right: 7),
        child:  Column(
          children: <Widget>[
            _items(context, itemList.sublist(0, 2), true),
            _items(context, itemList.sublist(2, 4), false),
            _items(context, itemList.sublist(4, 6), false),
          ],
        ),)
      ],
    );
  }

  Widget _items(BuildContext context, List<CommonModel> list, bool isBig) {
    return Row(
      children: <Widget>[
        _item(context, list[0], isBig, false),
        _item(context, list[1], isBig, true)
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel model, bool isBig, isLast) {
    BorderSide borderSide=BorderSide(color: const Color(0x11111111),width: 1);
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
      child: Container(
        decoration: BoxDecoration(
          border:Border(left: isLast?borderSide:BorderSide.none,bottom: borderSide)
        ),
        child: Image.network(
          model.icon,
          width: MediaQuery.of(context).size.width / 2 - 8,
          height: isBig?129:80,
        ),
      ),
    );
  }
}
