import 'package:untitled4/model/common_model.dart';

class GridNavItem {
  final String endColor;
  final String startColor;
  final CommonModel item1;
  final CommonModel item2;
  final CommonModel item3;
  final CommonModel item4;
  final CommonModel mainItem;

  GridNavItem(
      {this.endColor,
      this.startColor,
      this.item1,
      this.item2,
      this.item3,
      this.item4,
      this.mainItem});

  factory GridNavItem.fromJson(Map<String, dynamic> json) {
    return GridNavItem(
      endColor: json['endColor'],
      startColor: json['startColor'],
      item1: CommonModel.fromjson(json['item1']),
      item2: CommonModel.fromjson(json['item2']),
      item3: CommonModel.fromjson(json['item3']),
      item4: CommonModel.fromjson(json['item4']),
      mainItem: CommonModel.fromjson(json['mainItem']),
    );
  }
}
