import 'package:untitled4/model/common_model.dart';
import 'package:untitled4/model/grid_navItem_model.dart';

class GridNavModel {
  final GridNavItem flight;
  final GridNavItem hotel;
  final GridNavItem travel;

  GridNavModel({this.flight, this.hotel, this.travel});

  factory GridNavModel.fromJson(Map<String, dynamic> json) {
    return GridNavModel(
        flight: GridNavItem.fromJson(json['flight']),
        hotel: GridNavItem.fromJson(json['hotel']),
        travel: GridNavItem.fromJson(json['travel']));
  }
}
