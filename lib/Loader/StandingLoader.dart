import 'dart:collection';
import 'dart:convert';

import 'package:Score/Model/StandingItem.dart';
import 'package:Score/Model/Team.dart';
import 'package:Score/constants.dart';
import 'package:http/http.dart' as http;

class StandingLoader {
  static HashMap<String, List<StandingItem>> map = new HashMap();
  static String? key = null;

  static Future<List<StandingItem>> fetchStanding(
      int leagueId, int seasonId) async {
    key = leagueId.toString() + ":" + seasonId.toString();
    if (map.containsKey(key)) return map[key]!;
    String url = Constants.standings
        .replaceFirst("{league_id}", leagueId.toString())
        .replaceFirst("{season_id}", seasonId.toString());
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("standings fetched");
      return parseStanding(response.body);
    } else
      print("Standings not fetched");
    throw Exception("Could not fetch Standings");
  }

  static List<StandingItem> parseStanding(response) {
    final responseList = json.decode(response)["standings"][0]["rows"];
    List<StandingItem> standings = [];
    for (var s in responseList) {
      standings.add(new StandingItem(
          getTeam(s["team"]),
          s["position"],
          s["matches"],
          s["wins"],
          s["losses"],
          s["draws"],
          s["scoresFor"],
          s["scoresAgainst"],
          s["points"],
          s["id"]));
      print(s["position"].toString() + " done");
    }
    print("standings parsed");
    map[key!] = standings;
    return standings;
  }

  static getTeam(response) {
    return new Team(response["name"], response["id"], response["slug"],
        response["shortName"], response["nameCode"], response["userCount"]);
  }
}
