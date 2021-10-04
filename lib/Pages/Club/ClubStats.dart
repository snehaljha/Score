import 'package:Score/Loader/TeamSeasonsLoader.dart';
import 'package:Score/Model/League.dart';
import 'package:Score/Model/Team.dart';
import 'package:flutter/material.dart';

import 'ClubStatsTable.dart';

class ClubStats extends StatelessWidget {
  late Team _team;

  ClubStats({Key? key, required Team team}) : super(key: key) {
    this._team = team;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: _getContent(context),
    );
  }

  Widget _getContent(ct) {
    return FutureBuilder<List<League>>(
      future: TeamSeasonLoader.fetch(_team.id),
      builder: (BuildContext ct, AsyncSnapshot<List<League>> snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: Text("Loading..."),
          );
        return ClubStatsTable(team: _team, leagues: snapshot.data!);
      },
    );
  }
}
