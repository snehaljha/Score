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

class AllMatchesLoader {
  static HashMap<String, List<Match>> map = new HashMap();
  static String? key;

  static Future<List<Match>> fetchAllMatches() async {
    DateTime dt = DateTime.now();
    key = dt.year.toString() +
        "-" +
        dt.month.toString().padLeft(2, '0') +
        "-" +
        dt.day.toString().padLeft(2, '0');
    if (!map.containsKey(key) || map[key] == null) {
      String url = Constants.fixtureByDate.replaceFirst("yyyy-mm-dd", key!);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print("all matches fetched");
        return parseAllMatches(response.body);
      } else {
        print("all matches not found");
        throw Exception("Can't fetch Leagues");
      }
    } else {
      return map[key]!;
    }
  }

  static List<Match> parseAllMatches(responseBody) {
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
        print((j++).toString() + " " + m.category.name);
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
        print((j++).toString() + " " + m.category.name);
      }
    }
    map[key!] = matches;
    print("all matches parsed");
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
