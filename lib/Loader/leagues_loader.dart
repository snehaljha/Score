import 'dart:convert';

import 'package:Score/Model/League.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class LeaguesLoader {
  static List<League>? leagues = null;

  static List<League> parseLeagues(responseBody) {
    final parsed = json.decode(responseBody)["groups"][0]["uniqueTournaments"];
    List<League> cats = [];
    parsed.forEach((i) =>
        cats.add(new League(i["name"], i["slug"], i["id"], i["userCount"])));
    leagues = cats;
    return cats;
  }

  static Future<List<League>> fetchLeagues(url) async {
    if (leagues == null) {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return parseLeagues(response.body);
      } else {
        var logger = Logger();
        logger.e("could not fetch Leagues : " + response.statusCode.toString());
      }
      throw Exception("Can't fetch Leagues");
    } else {
      return leagues!;
    }
  }
}
