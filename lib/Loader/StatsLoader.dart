import 'dart:collection';
import 'dart:convert';

import 'package:Score/Model/Player.dart';
import 'package:Score/Model/Season.dart';
import 'package:Score/Model/CountStats.dart';
import 'package:Score/Model/RelativeStats.dart';
import 'package:Score/constants.dart';
import 'package:http/http.dart' as http;

class StatsLoader {
  static HashMap<String, HashMap<String, Object>> map = new HashMap();
  static String key="";

  static Future<HashMap<String, Object>> fetchStats(int leagueId, int seasonId) async {
    key = leagueId.toString() + ":" + seasonId.toString();
    if (map.containsKey(key)) return map[key]!;
    String url =
        Constants.leagueStats.replaceFirst("{league_id}", leagueId.toString()).replaceFirst("{season_id}", seasonId.toString());
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("stats fetched");
      return parseStats(response.body, leagueId, seasonId);
    } else
    print("Stats not fetched");
      throw Exception("Could not fetch Seasons");
  }

  static HashMap<String, Object> parseStats(response, leagueid, seasonId) {
    final responseList = json.decode(response)["topPlayers"];
    HashMap<String, Object> allStats = new HashMap();
    allStats["goals"] = getCountStats("goals", responseList["goals"][0]);
    allStats["assists"] = getCountStats("assists", responseList["assists"][0]);
    allStats["goalsAssistsSum"] = getCountStats("goalsAssistsSum", responseList["goalsAssistsSum"][0]);
    allStats["keyPasses"] = getCountStats("keyPasses", responseList["keyPasses"][0]);
    allStats["accuratePasses"] = getRelativeStats("accuratePasses", responseList["accuratePasses"][0]);
    allStats["successfulDribbles"] = getRelativeStats("successfulDribbles", responseList["successfulDribbles"][0]);
    allStats["interceptions"] = getCountStats("interceptions", responseList["interceptions"][0]);
    allStats["tackles"] = getCountStats("tackles", responseList["tackles"][0]);
    allStats["clearances"] = getCountStats("clearances", responseList["clearances"][0]);
    allStats["saves"] = getCountStats("saves", responseList["saves"][0]);
    allStats["cleanSheet"] = getCountStats("cleanSheet", responseList["cleanSheet"][0]);
    allStats["leastConceded"] = getCountStats("leastConceded", responseList["leastConceded"][0]);
    allStats["yellowCards"] = getCountStats("yellowCards", responseList["yellowCards"][0]);
    allStats["redCards"] = getCountStats("redCards", responseList["redCards"][0]);
    print("stats parsed");
    map[key] = allStats;
    return allStats;
  }

  static CountStats getCountStats(String name, response) {
    return new CountStats(name, response["statistics"]["type"], response["statistics"][name], response["statistics"]["appearances"], response["statistics"]["id"], getPlayer(response["player"]));
  }

  static RelativeStats getRelativeStats(name, response) {
    return new RelativeStats(name, response["statistics"]["type"], response["statistics"][name], response["statistics"][name+"Percentage"], response["statistics"]["appearances"], response["statistics"]["id"], getPlayer(response["player"]));
  }

  static getPlayer(response) {
    return new Player(response["name"], response["slug"], response["shortName"], response["id"], response["position"], response["userCount"], response["team"]);
  }
}
