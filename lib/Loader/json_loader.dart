import 'dart:convert';

import 'package:Score/Model/category.dart';
import 'package:Score/constants.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class CategoriesLoader {
  static List<Category>? categories = null;

  static List<Category> parseCategory(responseBody) {
    final parsed = json.decode(responseBody)["categories"];
    List<Category> cats = [];
    parsed.forEach((i) => cats.add(new Category(
        i["name"], i["slug"], i["id"], i["priority"], i["flag"], i["alpha2"])));
    categories = cats;
    return cats;
  }

  static Future<List<Category>> fetchCategories() async {
    if (categories == null) {
      final response = await http.get(Constants.host + Constants.categories);
      if (response.statusCode == 200) {
        return parseCategory(response.body);
      } else {
        var logger = Logger();
        logger.e(
            "could not fetch categories : " + response.statusCode.toString());
      }
      throw Exception("Can't fetch categories");
    } else {
      return categories!;
    }
  }
}
