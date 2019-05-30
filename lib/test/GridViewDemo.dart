import 'package:flutter/material.dart';

class GridViewDemo extends StatefulWidget {
  @override
  _GridViewState createState() => _GridViewState();
}

class _GridViewState extends State<GridViewDemo> {
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
      body: RefreshIndicator(child: GridView.count(
        crossAxisCount: 3,
        controller: _controller,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(left: 10,right: 10,top: 10),
        physics: AlwaysScrollableScrollPhysics(),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: _buildList(),
          ), onRefresh: _refresh)
    );
  }

  List<Widget> _buildList() {
    return citys.map((city)=>_getItem(city)).toList();
  }

  Widget _getItem(String city) {
    return GestureDetector(
      onTap: (){
        print('city: $city');
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(color: Colors.blue),
        child: Center(
          child: Text(city,style: TextStyle(fontSize: 20,color: Colors.white),),
        ),
      ),
    );
  }

}
