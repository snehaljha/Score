import 'dart:collection';
import 'dart:convert';

import 'package:Score/Model/League.dart';
import 'package:Score/constants.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class LeaguesLoader {

  static HashMap<int, List<League>> map = new HashMap();

  static List<League> parseLeagues(id, responseBody) {
    final parsed = json.decode(responseBody)["groups"][0]["uniqueTournaments"];
    List<League> cats = [];
    parsed.forEach((i) =>
        cats.add(new League(i["name"], i["slug"], i["id"], i["userCount"])));
    map[id] = cats;
    return cats;
  }

  static Future<List<League>> fetchLeagues(int id) async {
    if (!map.containsKey(id) || map[id] == null) {
      String url = Constants.league.replaceFirst("{category_id}", id.toString());
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return parseLeagues(id, response.body);
      } else {
        var logger = Logger();
        logger.e("could not fetch Leagues : " + response.statusCode.toString());
      }
      throw Exception("Can't fetch Leagues");
    } else {
      return map[id]!;
    }
  }
}
