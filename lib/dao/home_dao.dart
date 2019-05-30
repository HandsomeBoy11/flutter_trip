import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:untitled4/model/home_model.dart';

const HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';

class HomeDao {
  static Future<HomeModel> fetch() async {
    var response = await http.get(HOME_URL);
    if (response.statusCode == 200) {
      Utf8Decoder utf8encode = Utf8Decoder();
      var result = json.decode(utf8encode.convert(response.bodyBytes));
      HomeModel homeModel = HomeModel.fromJson(result);
      return homeModel;
    } else {
      throw Exception('首页请求出现异常');
    }
  }
}
