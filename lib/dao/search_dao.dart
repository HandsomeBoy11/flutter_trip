import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:untitled4/model/home_model.dart';
import 'package:untitled4/model/search_model.dart';

//const HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';

class SearchDao {
  static Future<SearchModel> fetch(String url) async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Utf8Decoder utf8encode = Utf8Decoder();
      var result = json.decode(utf8encode.convert(response.bodyBytes));
      SearchModel homeModel = SearchModel.fromJson(result);
      return homeModel;
    } else {
      throw Exception('搜索请求出现异常');
    }
  }
}
