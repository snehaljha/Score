import 'dart:convert';
import 'package:Score/Model/Team.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class TopTeamsLoader {
  static List<Team>? topTeams;

  static Future<List<Team>> fetchTopTeams() async {
    if (topTeams != null) return topTeams!;
    String url = Constants.topTeams;
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("top teams fetched");
      return parseTopTeams(response.body);
    } else {
      print("top teams not found");
      throw Exception("Can't fetch top teams");
    }
  }

  static List<Team> parseTopTeams(responseBody) {
    var parsed = json.decode(responseBody)["teams"];
    List<Team> topTeams = [];
    int j = 0;
    for (var i in parsed) {
      if (j++ == 50) break;
      topTeams.add(new Team(i["name"], i["id"], i["slug"], i["shortName"],
          i["nameCode"], i["userCount"]));
    }
    print("top teams parsed");
    return topTeams;
  }
}
