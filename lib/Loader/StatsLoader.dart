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
    allStats["goals"] = getCountStats("goals", responseList["goals"]);
    allStats["assists"] = getCountStats("assists", responseList["assists"]);
    allStats["goalsAssistsSum"] = getCountStats("goalsAssistsSum", responseList["goalsAssistsSum"]);
    allStats["keyPasses"] = getCountStats("keyPasses", responseList["keyPasses"]);
    allStats["accuratePasses"] = getRelativeStats("accuratePasses", responseList["accuratePasses"]);
    allStats["successfulDribbles"] = getRelativeStats("successfulDribbles", responseList["successfulDribbles"]);
    allStats["interceptions"] = getCountStats("interceptions", responseList["interceptions"]);
    allStats["tackles"] = getCountStats("tackles", responseList["tackles"]);
    allStats["clearances"] = getCountStats("clearances", responseList["clearances"]);
    allStats["saves"] = getCountStats("saves", responseList["saves"]);
    allStats["cleanSheet"] = getCountStats("cleanSheet", responseList["cleanSheet"]);
    allStats["leastConceded"] = getCountStats("leastConceded", responseList["leastConceded"]);
    allStats["yellowCards"] = getCountStats("yellowCards", responseList["yellowCards"]);
    allStats["redCards"] = getCountStats("redCards", responseList["redCards"]);
    map[key] = allStats;
    return allStats;
  }

  static CountStats getCountStats(String name, response) {
    return new CountStats(name, response["type"], response[name], response["appearance"], response["id"], getPlayer(response["player"]));
  }

  static RelativeStats getRelativeStats(name, response) {
    return new RelativeStats(name, response["type"], name, name+"Percentage", response["appearances"], response["id"], getPlayer(response["player"]));
  }

  static getPlayer(response) {
    return new Player(response["name"], response["slug"], response["shortName"], response["id"], response["position"], response["userCount"], response["team"]);
  }
}
