import 'package:Score/Loader/TitlesLoader.dart';
import 'package:Score/Model/League.dart';
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
          Container(
            child: Column(
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
                  future: TitlesLeader.fetchTitles(league.id),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Object>> snapshot) {
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
                )
              ],
            ),
          ),
          Container(child: Center(child: Text("Matches"),),),
          Container(child: Center(child: Text("Standings"),),)
        ]),
      ),
    );
  }
}
