import 'package:Score/Model/Team.dart';
import 'package:Score/Pages/Club/ClubMatches.dart';
import 'package:Score/Pages/Club/ClubSquad.dart';
import 'package:flutter/material.dart';

import 'ClubStats.dart';

class ClubPage extends StatefulWidget {
  Team team;
  ClubPage({Key? key, required this.team}) : super(key: key);

  @override
  _ClubPageState createState() => _ClubPageState(team);
}

class _ClubPageState extends State<ClubPage> {
  Team team;

  _ClubPageState(this.team);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(team.name),
          bottom: TabBar(
            tabs: [Text("Matches"), Text("Squad"), Text("Stats")],
          ),
        ),
        body: TabBarView(children: [
          ClubMatches(
            team: team,
          ),
          ClubSquad(team: team),
          ClubStats(team: team)
        ]),
      ),
    );
  }
}
