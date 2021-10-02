import 'dart:collection';
import 'dart:convert';

import 'package:Score/Model/Player.dart';
import 'package:Score/Model/Team.dart';
import 'package:Score/constants.dart';
import 'package:http/http.dart' as http;

class SquadLoader {
  static HashMap<int, List<Player>> _map = new HashMap();
  static List<String> _sortSequence = ["G", "D", "M", "F"];

  static fetchSquad(Team team) async {
    if (_map.containsKey(team.id) && _map[team.id] != null) {
      return _map[team.id];
    }
    String url =
        Constants.teamPLayers.replaceFirst("{team_id}", team.id.toString());
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("squad fetched");
      return _parse(response.body, team);
    } else {
      print("squad not fetched");
      throw Exception("squad not fetched");
    }
  }

  static List<Player> _parse(response, team) {
    final parsed = json.decode(response)["players"];
    List<Player> players = [];
    for (var i in parsed) {
      players.add(new Player.forSquadList(
          i["player"]["name"],
          i["player"]["slug"],
          i["player"]["shortName"],
          i["player"]["id"],
          i["player"]["position"],
          i["player"]["userCount"],
          team,
          i["player"]["preferredFoot"],
          i["player"]["shirtNumber"]));
    }

    players.sort((a, b) {
      int ap = _sortSequence.indexOf(a.position);
      int bp = _sortSequence.indexOf(b.position);
      if (ap != bp) {
        return ap.compareTo(bp);
      }
      if (a.userCount != b.userCount) {
        return -a.userCount.compareTo(b.userCount);
      }
      return a.name.compareTo(b.name);
    });
    _map[team.id] = players;
    return players;
  }
}
