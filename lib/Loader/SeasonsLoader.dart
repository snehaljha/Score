import 'dart:collection';
import 'dart:io';

import 'package:Score/Model/Season.dart';
import 'package:Score/constants.dart';
import 'package:http/http.dart' as http;

class SeasonsLoader {
  static HashMap<int, List<Season>> map = new HashMap();

  static Future<List<Season>> fetchSeasons(int leagueId) async {
    if (map.containsKey(leagueId)) return map[leagueId]!;
    String url =
        Constants.seasons.replaceFirst("{league_id}", leagueId.toString());
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return parseSeasons(response, leagueId);
    } else
      throw Exception("Could not fetch Seasons");
  }

  static List<Season> parseSeasons(response, leagueid) {
    final responseList = response["seasons"];
    List<Season> seasons = [];
    for (var s in responseList) {
      seasons.add(new Season(s["name"], s["year"], s["id"]));
    }
    map[leagueid] = seasons;
    return seasons;
  }
}
