import 'package:untitled4/model/common_model.dart';
import 'package:untitled4/model/config_model.dart';
import 'package:untitled4/model/grid_nav_model.dart';
import 'package:untitled4/model/salesBox_model.dart';

class HomeModel {
  final ConfigModel config;
  final SalesBoxModel salesBox;
  final GridNavModel gridNav;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;

  HomeModel(
      {this.config,
      this.salesBox,
      this.gridNav,
      this.bannerList,
      this.localNavList,
      this.subNavList});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var bannerLists = json['bannerList'] as List;
    List<CommonModel> bannerList =
        bannerLists.map((i) => CommonModel.fromjson(i)).toList();
    var locaNavLists = json['localNavList'] as List;
    List<CommonModel> locaNavList = locaNavLists.map((i) => CommonModel.fromjson(i)).toList();

    var subNavLists = json['subNavList'] as List;
    List<CommonModel> subNavList = subNavLists.map((i) => CommonModel.fromjson(i)).toList();

    return HomeModel(
      config: ConfigModel.fromJson(json['config']),
      salesBox: SalesBoxModel.fromJson(json['salesBox']),
      gridNav: GridNavModel.fromJson(json['gridNav']),
      bannerList: bannerList,
      localNavList: locaNavList,
      subNavList: subNavList,
    );
  }
}
