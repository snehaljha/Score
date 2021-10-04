import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Score/constants.dart';

class TeamStatsLoader {
  static HashMap<String, List<List<Object>>> _map = new HashMap();
  static String? _key;

  static Future<List<List<Object>>> fetch(
      int teamId, int leagueId, int seasonId) async {
    _key = teamId.toString() +
        ":" +
        leagueId.toString() +
        ":" +
        seasonId.toString();
    if (_map.containsKey(_key) && _map[_key] != null) return _map[_key]!;

    String url = Constants.teamOverallStats
        .replaceFirst("{team_id}", teamId.toString())
        .replaceFirst("{league_id}", leagueId.toString())
        .replaceFirst("{season_id}", seasonId.toString());
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("team stats loader fetched");
      return _parse(response.body);
    }
    print("not fetched team stats loader");
    throw Exception("not fetched team stats loader");
  }

  static List<List<Object>> _parse(response) {
    var parsed = json.decode(response)["statistics"];
    List<String> keys = parsed.keys.toList();
    List<List<Object>> res = [];
    for (String s in keys) {
      res.add([s, parsed[s]]);
    }

    _map[_key!] = res;
    return res;
  }
}
