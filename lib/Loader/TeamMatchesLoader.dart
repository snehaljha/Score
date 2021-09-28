import 'dart:convert';
import 'dart:collection';
import 'package:Score/Model/Match.dart';
import 'package:Score/Model/MatchScore.dart';
import 'package:Score/Model/Status.dart';
import 'package:Score/Model/Team.dart';
import 'package:Score/Model/category.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../constants.dart';

class TeamMatchesLoader {
  HashMap<int, List<Match>> map = new HashMap();
  static Future<List<Match>> fetchTeamMatches(int teamId) async {
    String url =
        Constants.teamPastMatches.replaceFirst("{team_id}", teamId.toString());
    final response1 = await http.get(url);
    url =
        Constants.teamNextMatches.replaceFirst("{team_id}", teamId.toString());
    final response2 = await http.get(url);
    if (response1.statusCode == 200 && response2.statusCode == 200) {
      print("team matches fetched");
      return parseTeamMatches(response1.body, response2.body);
    } else {
      print("team matches not found");
      throw Exception("Can't fetch team matches");
    }
  }

  static List<Match> parseTeamMatches(responseBody1, responseBody2) {
    List<Match> matches = parseResponse(responseBody1);
    matches.addAll(parseResponse(responseBody2));
    print("team matches parsed");
    return matches;
  }

  static List<Match> parseResponse(responseBody) {
    var parsed = json.decode(responseBody)["events"];
    List<Match> matches = [];
    int j = 1;
    for (var i in parsed) {
      if (i["tournament"]["uniqueTournament"] != null) {
        Match m = new Match(
            getCategory(i["tournament"]["uniqueTournament"]),
            i["status"]["code"],
            getTeam(i["homeTeam"]),
            getTeam(i["awayTeam"]),
            getScore(i["homeScore"], i["status"]["code"]),
            getScore(i["awayScore"], i["status"]["code"]),
            i["id"],
            i["startTimestamp"]);
        matches.add(m);
      } else {
        Match m = new Match(
            getCategory(i["tournament"]["category"]),
            i["status"]["code"],
            getTeam(i["homeTeam"]),
            getTeam(i["awayTeam"]),
            getScore(i["homeScore"], i["status"]["code"]),
            getScore(i["awayScore"], i["status"]["code"]),
            i["id"],
            i["startTimestamp"]);
        matches.add(m);
      }
    }
    return matches;
  }

  static Category getCategory(response) {
    return new Category(
        response["name"], response["slug"], response["id"], 0, "", "");
  }

  static Team getTeam(response) {
    return new Team(response["name"], response["id"], response["slug"],
        response["shortName"], response["nameCode"], response["userCount"]);
  }

  static MatchScore? getScore(response, int code) {
    if (!Status.isScoreNeeded(code)) return null;
    return new MatchScore(response["current"], response["display"],
        response["period1"], response["normaltime"]);
  }
}
