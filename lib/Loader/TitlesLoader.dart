import 'dart:collection';
import 'dart:convert';

import 'package:Score/Model/Team.dart';
import 'package:Score/constants.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class TitlesLoader {
  static HashMap<int, List<Object>> map = new HashMap();

  static List<Object> parseTitles(id, responseBody) {
    final parsed = json.decode(responseBody)["uniqueTournament"];
    List<Object> cats = [];
    cats.add(parsed["titleHolderTitles"]);
    cats.add(parsed["mostTitles"]);
    final champs = parsed["titleHolder"];
    cats.add(new Team(champs["name"], champs["id"], champs["slug"], champs["shortName"], champs["nameCode"], champs["userCount"]));
    final mostTT = parsed["mostTitlesTeams"][0];
    cats.add(new Team(mostTT["name"], mostTT["id"], mostTT["slug"], mostTT["shortName"], mostTT["nameCode"], mostTT["userCount"]));
    map[id] = cats;
    return cats;
  }

  static Future<List<Object>> fetchTitles(int id) async {
    if (!map.containsKey(id) || map[id] == null) {
      String url = Constants.leagueOverview.replaceFirst("{league_id}", id.toString());
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print("fetched");
        return parseTitles(id, response.body);
      } else {
        print("not found title holders");
        var logger = Logger();
        logger.e("could not fetch Leagues : " + response.statusCode.toString());
      }
      throw Exception("Can't fetch Leagues");
    } else {
      return map[id]!;
    }
  }
}