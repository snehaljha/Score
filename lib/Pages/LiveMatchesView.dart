import 'package:Score/Loader/LiveMatchesLoader.dart';
import 'package:Score/Model/Match.dart';
import 'package:Score/Model/Status.dart';
import 'package:Score/Pages/menu.dart';
import 'package:flutter/material.dart';

class LiveMatchesView extends StatefulWidget {
  const LiveMatchesView({Key? key}) : super(key: key);

  @override
  _LiveMatchesViewState createState() => _LiveMatchesViewState();
}

class _LiveMatchesViewState extends State<LiveMatchesView> {
  ListView getMatchList(List<Match> matches) {
    matches.sort();
    String date = "dd/mm/yyyy";
    String cat = "cat";
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
      if (cat != m.category.name) {
        members.add(Container(
            margin: EdgeInsets.all(5.0), child: new Text(m.category.name)));
        cat = m.category.name;
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
              Column(
                children: [
                  Text(m.getCurrentScore()),
                  Text(Status.getStatusMSG(m.statusCode))
                ],
              ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: Drawer(
        child: Menu(),
      ),
      body: Container(
        child: FutureBuilder<List<Match>>(
          future: LiveMatchesLoader.fetchLiveMatches(),
          builder: (BuildContext context, AsyncSnapshot<List<Match>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text("Loading..."),
              );
            }
            return getMatchList(snapshot.data!);
          },
        ),
      ),
    );
  }
}
