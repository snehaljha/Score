import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Score/Model/League.dart';
import 'package:Score/constants.dart';

class TeamSeasonLoader {
  static HashMap<int, List<League>> _map = new HashMap();

  static Future<List<League>> fetch(int teamId) async {
    if (_map.containsKey(teamId) && _map[teamId] != null) {
      return _map[teamId]!;
    }
    String url =
        Constants.teamStatsSeason.replaceFirst("{team_id}", teamId.toString());
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("team sesasons fetched");
      return _parse(teamId, response.body);
    }
    print("team seasons not fetched");
    throw Exception("team seasons not fetched");
  }

  static List<League> _parse(int teamId, response) {
    final parsed = json.decode(response)["uniqueTournamentSeasons"];
    List<League> leagues = [];
    for (var i in parsed) {
      i = i["uniqueTournament"];
      leagues.add(new League.seasonsJSON(
          i["name"], i["slug"], i["id"], i["userCount"], i["seasons"]));
    }
    _map[teamId] = leagues;
    print("parsed team season");
    return leagues;
  }
}
