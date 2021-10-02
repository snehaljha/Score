import 'dart:collection';
import 'dart:convert';

import 'package:Score/Model/Player.dart';
import 'package:Score/Model/Team.dart';
import 'package:Score/constants.dart';
import 'package:http/http.dart' as http;

class TeamInfoLoader {
  static HashMap<int, HashMap<String, Object>> _map = new HashMap();
  static Team? _teamp = null;

  static Future<String> fetchStadiumName(int teamId) async {
    return (await _fetch(teamId))["name"]! as String;
  }

  static Future<Player> fetchManager(Team team) async {
    _teamp = team;
    return (await _fetch(team.id))["manager"] as Player;
  }

  static Future<HashMap<String, Object>> _fetch(int id) async {
    if (!_map.containsKey(id) || _map[id] == null) {
      String url = Constants.teamInfo.replaceFirst("{team_id}", id.toString());
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print("fetched team info");
        return _parse(id, response.body);
      } else {
        print("not fetched team info");
        throw Exception("not fetched team info");
      }
    } else {
      return _map[id]!;
    }
  }

  static HashMap<String, Object> _parse(id, responseBody) {
    var parsed = json.decode(responseBody)["team"];
    HashMap<String, Object> res = new HashMap();
    String stadiumName = parsed["venue"]["stadium"]["name"];
    parsed = parsed["manager"];
    Player manager = new Player(parsed["name"], parsed["slug"],
        parsed["shortName"], parsed["id"], "coach", 0, _teamp!);
    res["manager"] = manager;
    res["name"] = stadiumName;
    _map[id] = res;
    print("parsed team info");
    return res;
  }
}
