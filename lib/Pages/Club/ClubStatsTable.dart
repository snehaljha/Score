import 'package:Score/Loader/TeamStatsLoader.dart';
import 'package:Score/Model/League.dart';
import 'package:Score/Model/Season.dart';
import 'package:Score/Model/Team.dart';
import 'package:flutter/material.dart';

class ClubStatsTable extends StatefulWidget {
  late Team _team;
  late List<League> _leagues;

  ClubStatsTable({Key? key, required Team team, required List<League> leagues})
      : super(key: key) {
    _team = team;
    _leagues = leagues;
  }

  @override
  _ClubStatsTableState createState() => _ClubStatsTableState(_team, _leagues);
}

class _ClubStatsTableState extends State<ClubStatsTable> {
  Team _team;
  List<League> _leagues;
  late League _selectedLeague;
  late Season _selectedSeason;
  late List<DropdownMenuItem<Season>> _seasonItems;

  _ClubStatsTableState(this._team, this._leagues) {
    _selectedLeague = _leagues[0];
    _selectedSeason = _leagues[0].seasons![0];
    for (Season season in _leagues[0].seasons!) {
      _seasonItems
          .add(DropdownMenuItem(value: season, child: Text(season.name)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [_getLeaguePicker(context), _getStatsTable(context)],
      ),
    );
  }

  Widget _getLeaguePicker(ct) {
    List<DropdownMenuItem<League>> leagueItems = [];
    for (League league in _leagues) {
      leagueItems
          .add(DropdownMenuItem(value: league, child: Text(league.name)));
    }
    return Row(
      children: [
        DropdownButtonFormField<League>(
          items: leagueItems,
          value: _selectedLeague,
          onChanged: (League? newLeague) {
            if (newLeague == null) return;
            _selectedLeague = newLeague;
            _selectedSeason = newLeague.seasons![0];
            for (Season season in newLeague.seasons!) {
              _seasonItems.add(
                  DropdownMenuItem(value: season, child: Text(season.name)));
            }
            setState(() {});
          },
        ),
        DropdownButtonFormField<Season>(
          items: _seasonItems,
          value: _selectedSeason,
          onChanged: (Season? newSeason) {
            if (newSeason == null) return;
            _selectedSeason = newSeason;
            setState(() {});
          },
        )
      ],
    );
  }

  Widget _getStatsTable(ct) {
    return FutureBuilder<List<List<Object>>>(
      future: TeamStatsLoader.fetch(
          _team.id, _selectedLeague.id, _selectedSeason.id),
      builder: (BuildContext ct, AsyncSnapshot<List<List<Object>>> snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: Text("Loading..."),
          );

        return _getTable(ct, snapshot.data!);
      },
    );
  }

  Column _getTable(ct, List<List<Object>> data) {
    List<Widget> members = [];
    for (var i in data) {
      members.add(Row(
        children: [
          Expanded(child: Container(child: Text(i[0] as String))),
          Text(_parseData(i[1]))
        ],
      ));
    }
    return Column(
      children: members,
    );
  }

  String _parseData(Object obj) {
    try {
      return (obj as int).toString();
    } catch (ex) {
      return (obj as double).toString();
    }
  }
}
