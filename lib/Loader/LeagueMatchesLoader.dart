import 'dart:convert';
import 'dart:collection';
import 'package:Score/Model/Match.dart';
import 'package:Score/Model/MatchScore.dart';
import 'package:Score/Model/Team.dart';
import 'package:Score/Model/category.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../constants.dart';

class LeagueMatchesLoader {
  static HashMap<String, List<Match>> map = new HashMap();
  static String? key;

  static Future<List<Match>> fetchLeagueMatches(
      int leagueId, int seasonId) async {
    key = leagueId.toString() + ":" + seasonId.toString();
    if (!map.containsKey(key) || map[key] == null) {
      String url = Constants.leaguePastMatches
          .replaceFirst("{league_id}", leagueId.toString())
          .replaceFirst("{season_id}", seasonId.toString());
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print("leahue matches fetched");
        return parseLeagueMatches(response.body);
      } else {
        print("league matchesnot found");
        throw Exception("Can't fetch Leagues");
      }
    } else {
      return map[key]!;
    }
  }

  static List<Match> parseLeagueMatches(responseBody) {
    var parsed = json.decode(responseBody)["tournamentTeamEvents"];
    String mainKey = parsed.keys.toList()[0];
    parsed = parsed[mainKey];
    List<Match> matches = [];
    List<String> subKeys = parsed.keys.toList();
    HashSet<int> ids = new HashSet();
    for (String k in subKeys) {
      for (var i in parsed[k]) {
        Match m = new Match(
            getCategory(i["tournament"]["uniqueTournament"]),
            i["status"]["code"],
            getTeam(i["homeTeam"]),
            getTeam(i["awayTeam"]),
            getScore(i["homeScore"]),
            getScore(i["awayScore"]),
            i["id"],
            i["startTimestamp"]);
        if (!ids.contains(m.id)) {
          ids.add(m.id);
          matches.add(m);
        }
      }
    }
    map[key!] = matches;
    print("league matches parsed");
    return matches;
  }

  static getCategory(response) {
    return new Category(
        response["name"], response["slug"], response["id"], 0, "", "");
  }

  static getTeam(response) {
    return new Team(response["name"], response["id"], response["slug"],
        response["shortName"], response["nameCode"], response["userCount"]);
  }

  static getScore(response) {
    return new MatchScore(response["current"], response["display"],
        response["period1"], response["normaltime"]);
  }
}
