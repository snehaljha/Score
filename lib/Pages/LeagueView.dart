import 'dart:collection';

import 'package:Score/Loader/LeagueMatchesLoader.dart';
import 'package:Score/Loader/SeasonsLoader.dart';
import 'package:Score/Loader/StatsLoader.dart';
import 'package:Score/Loader/TitlesLoader.dart';
import 'package:Score/Model/CountStats.dart';
import 'package:Score/Model/League.dart';
import 'package:Score/Model/Match.dart';
import 'package:Score/Model/Player.dart';
import 'package:Score/Model/RelativeStats.dart';
import 'package:Score/Model/Season.dart';
import 'package:Score/Model/Team.dart';
import 'package:flutter/material.dart';

class LeagueView extends StatefulWidget {
  LeagueView({Key? key, required this.league}) : super(key: key);

  League league;
  @override
  _LeagueViewState createState() => _LeagueViewState(league);
}

class _LeagueViewState extends State<LeagueView> {
  _LeagueViewState(this.league);
  League league;
  int? seasonId = null;
  HashMap<String, Object>? stats = null;
  String selectedYear = "";

  Future<List<Season>> getSeasons() async {
    List<Season> seasons = await SeasonsLoader.fetchSeasons(league.id);
    this.seasonId = seasons[0].id;
    if (stats == null)
      stats = await StatsLoader.fetchStats(league.id, seasonId!);
    return seasons;
  }

  Future<HashMap<String, Object>> getStats() async {
    HashMap<String, Object> allStats =
        await StatsLoader.fetchStats(league.id, seasonId!);
    return allStats;
  }

  Column statsColumn(HashMap<String, Object> allStats) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: getCountStatsCard(
                    allStats["goals"] as CountStats, "goals")),
            Expanded(
              child: getCountStatsCard(
                  allStats["assists"] as CountStats, "assists"),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: getCountStatsCard(
                  allStats["goalsAssistsSum"] as CountStats, "Goals+Assists"),
            ),
            Expanded(
              child: getCountStatsCard(
                  allStats["keyPasses"] as CountStats, "Key Passes"),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: getRelativeStatsCard(
                  allStats["accuratePasses"] as RelativeStats, "Acc. Passes"),
            ),
            Expanded(
              child: getRelativeStatsCard(
                  allStats["successfulDribbles"] as RelativeStats, "Dribbles"),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: getCountStatsCard(
                  allStats["interceptions"] as CountStats, "Interception"),
            ),
            Expanded(
              child: getCountStatsCard(
                  allStats["tackles"] as CountStats, "Tackles"),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: getCountStatsCard(
                  allStats["clearances"] as CountStats, "Clearances"),
            ),
            Expanded(
              child:
                  getCountStatsCard(allStats["saves"] as CountStats, "Saves"),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: getCountStatsCard(
                  allStats["cleanSheet"] as CountStats, "Clean Sheet"),
            ),
            Expanded(
              child: getCountStatsCard(
                  allStats["leastConceded"] as CountStats, "Least Conceded"),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: getCountStatsCard(
                  allStats["yellowCards"] as CountStats, "Yellow Cards"),
            ),
            Expanded(
              child: getCountStatsCard(
                  allStats["redCards"] as CountStats, "Red Cards"),
            )
          ],
        ),
      ],
    );
  }

  Card getCountStatsCard(CountStats stat, String label) {
    Player player = stat.player;
    return Card(
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: [
            Text(label),
            Image.network(
              player.photo,
              width: 50,
              height: 50,
            ),
            Text(player.name + " - " + stat.count.toString())
          ],
        ),
      ),
    );
  }

  Card getRelativeStatsCard(RelativeStats stat, String label) {
    Player player = stat.player;
    return Card(
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: [
            Text(label),
            Image.network(
              player.photo,
              width: 50,
              height: 50,
            ),
            Text(player.name +
                " - " +
                stat.count.toString() +
                " (" +
                stat.precentage.toString() +
                "%)")
          ],
        ),
      ),
    );
  }

  //FirstTab
  Container getLeagueOverview() {
    return Container(
      child: ListView(
        children: [
          Card(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    league.leagueLogoUrl,
                    width: 50,
                    height: 50,
                  ),
                  Text(league.name)
                ],
              ),
            ),
          ),
          FutureBuilder<List<Object>>(
            future: TitlesLoader.fetchTitles(league.id),
            builder:
                (BuildContext context, AsyncSnapshot<List<Object>> snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Can't get champions"),
                  ),
                );
              }
              Team lastChamp = snapshot.data![2] as Team;
              Team mostChamp = snapshot.data![3] as Team;
              int lastChampCount = snapshot.data![0] as int;
              int mostChampCount = snapshot.data![1] as int;
              return Row(
                children: [
                  Expanded(
                      child: Card(
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Image.network(
                            lastChamp.teamLogo,
                            width: 50,
                            height: 50,
                          ),
                          Text(lastChamp.name +
                              " (" +
                              lastChampCount.toString() +
                              ")")
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                      child: Card(
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Image.network(
                            mostChamp.teamLogo,
                            width: 50,
                            height: 50,
                          ),
                          Text(mostChamp.name +
                              " (" +
                              mostChampCount.toString() +
                              ")")
                        ],
                      ),
                    ),
                  ))
                ],
              );
            },
          ),
          FutureBuilder<List<Season>>(
            future: getSeasons(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Season>> snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  child: Center(
                    child: Text("Loading"),
                  ),
                );
              }
              print("data found");
              List<String> labels = [];
              List<DropdownMenuItem<String>> ddi = [];
              snapshot.data!.forEach((d) => labels.add(d.year));
              labels.forEach((l) => ddi.add(DropdownMenuItem(
                    value: l,
                    child: Text(l),
                  )));
              selectedYear = labels[0];
              return Column(children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: DropdownButtonFormField<String>(
                    value: selectedYear,
                    items: ddi,
                    onChanged: (String? newValue) async {
                      for (Season season in snapshot.data!) {
                        if (season.year == newValue) this.seasonId = season.id;
                      }
                      this.stats = await getStats();
                      selectedYear = newValue!;
                      setState(() {
                        selectedYear;
                      });
                    },
                  ),
                ),
                statsColumn(stats!)
              ]);
            },
          ),
        ],
      ),
    );
  }

  Future<List<Match>> getMatches() async {
    Season firstSeason = (await SeasonsLoader.fetchSeasons(league.id))[0];
    List<Match> matches =
        await LeagueMatchesLoader.fetchLeagueMatches(league.id, firstSeason.id);
    matches.sort((a, b) => b.compareTo(a));
    return matches;
  }

  ListView getMatchList(List<Match> matches) {
    String date = "dd/mm/yyyy";
    List<Widget> members = [];
    for (Match m in matches) {
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(m.startTimestamp * 1000);
      String matchDate = dateTime.day.toString() +
          "/" +
          dateTime.month.toString() +
          "/" +
          dateTime.year.toString();
      if (date != matchDate) {
        members.add(
            Container(margin: EdgeInsets.all(5.0), child: new Text(matchDate)));
        date = matchDate;
      }
      members.add(Card(
        margin: EdgeInsets.all(5.0),
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(dateTime.hour.toString() + ":" + dateTime.minute.toString()),
              Row(
                children: [
                  Text(m.homeTeam.name),
                  Image.network(
                    m.homeTeam.teamLogo,
                    height: 30.0,
                    width: 30.0,
                  )
                ],
              ),
              Text(m.homeScore.current.toString() +
                  " - " +
                  m.awayScore.current.toString()),
              Row(
                children: [
                  Image.network(
                    m.awayTeam.teamLogo,
                    height: 30.0,
                    width: 30.0,
                  ),
                  Text(m.awayTeam.name)
                ],
              ),
            ],
          ),
        ),
      ));
    }
    return ListView(
      children: members,
    );
  }

  Container getLeagueMatches() {
    return Container(
        child: FutureBuilder<List<Match>>(
      future: getMatches(),
      builder: (BuildContext context, AsyncSnapshot<List<Match>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text("Loading..."),
          );
        }
        return getMatchList(snapshot.data!);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(league.name),
          bottom: TabBar(
            tabs: [Text("Overview"), Text("Matches"), Text("Standings")],
          ),
        ),
        body: TabBarView(children: [
          getLeagueOverview(),
          getLeagueMatches(),
          Container(
            child: Center(
              child: Text("Standings"),
            ),
          )
        ]),
      ),
    );
  }
}
