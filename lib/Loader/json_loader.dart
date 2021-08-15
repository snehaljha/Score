import 'dart:convert';

import 'package:Score/Model/country.dart';
import 'package:flutter/services.dart';

class JSONLoader {
  static Future<List<Country>> readCountries() async {
    final String content =
        await rootBundle.loadString("json/f_all_countries.json");
    final data = await json.decode(content);
    final response = data["response"];
    List<Country> countries = [];
    for (var i in response) {
      Country country = new Country(i["name"], i["code"], i["flag"]);
      countries.add(country);
    }
    return countries;
  }
}
