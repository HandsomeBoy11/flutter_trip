import 'package:flutter/material.dart';

class ListViewDemo extends StatefulWidget {
  @override
  _ListViewState createState() => _ListViewState();
}

class _ListViewState extends State<ListViewDemo> {
  List<String> citys = [
    '北京',
    '上海',
    '深圳',
    '蛟河',
  ];
  Future<Null> _refresh() async{
    await Future.delayed(Duration(seconds: 2));
    List<String> citysReversed=citys.reversed.toList();
    setState(() {
      citys=citysReversed;
    });

  }
  ScrollController _controller=ScrollController();
  @override
  void initState(){
    _controller.addListener((){
      if(_controller.position.pixels==_controller.position.maxScrollExtent){
        _loadData();
      }
    });
    super.initState();
  }

  void _loadData() async{
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {
      List<String> newList=List<String>.from(citys);
      newList.addAll(citys);
      citys=newList;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试listview'),
      ),
      body: RefreshIndicator(child: ListView.builder(
          itemCount: citys.length,
          controller: _controller,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                print('inde: $index   ${citys[index]}');
              },
              child: Container(
                height: 200,
                decoration: BoxDecoration(color: Colors.blue),
                margin: EdgeInsets.only(bottom: 3,left: 10,right: 10),
                padding: EdgeInsets.only(top: 5,bottom: 5),
                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: Center(
                    child: Text(citys[index]),
                  ),
                ),
              ),
            );
          }), onRefresh: _refresh)
    );
  }
}
