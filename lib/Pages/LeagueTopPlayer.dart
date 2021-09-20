import 'package:Score/Model/League.dart';
import 'package:Score/Model/Season.dart';
import 'package:flutter/material.dart';

class LeagueTopPlayer extends StatefulWidget {
  LeagueTopPlayer({Key? key, required this.league, required this.season})
      : super(key: key);
  League league;
  Season season;

  @override
  _LeagueTopPlayerState createState() => _LeagueTopPlayerState(league, season);
}

class _LeagueTopPlayerState extends State<LeagueTopPlayer> {
  _LeagueTopPlayerState(this.league, this.season);
  League league;
  Season season;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
