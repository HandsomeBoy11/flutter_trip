import 'package:untitled4/model/common_model.dart';

class SalesBoxModel {
  final CommonModel bigCard1;
  final CommonModel bigCard2;
  final CommonModel smallCard1;
  final CommonModel smallCard2;
  final CommonModel smallCard3;
  final CommonModel smallCard4;
  final String icon;
  final String moreUrl;

  SalesBoxModel(
      {this.smallCard1,
      this.smallCard2,
      this.smallCard3,
      this.smallCard4,
      this.bigCard1,
      this.bigCard2,
      this.icon,
      this.moreUrl});

  factory SalesBoxModel.fromJson(Map<String, dynamic> json) {
    return SalesBoxModel(
        icon: json['icon'],
        moreUrl: json['moreUrl'],
        bigCard1: CommonModel.fromjson(json['bigCard1']),
        bigCard2: CommonModel.fromjson(json['bigCard2']),
        smallCard1: CommonModel.fromjson(json['smallCard1']),
        smallCard2: CommonModel.fromjson(json['smallCard2']),
        smallCard3: CommonModel.fromjson(json['smallCard3']),
        smallCard4: CommonModel.fromjson(json['smallCard4']));
  }

  Map<dynamic,dynamic> toJson(){
    return {
      icon:icon,
      moreUrl:moreUrl,
      bigCard1:bigCard1,
      bigCard2:bigCard2,
      smallCard1:smallCard1,
      smallCard2:smallCard2,
      smallCard3:smallCard3,
      smallCard4:smallCard4
    };
  }
}
