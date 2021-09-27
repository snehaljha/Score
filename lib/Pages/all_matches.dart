import 'package:Score/Loader/AllMatchesLoader.dart';
import 'package:Score/Model/Status.dart';
import 'package:flutter/material.dart';
import 'package:Score/Model/Match.dart';

class AllMatches extends StatefulWidget {
  const AllMatches({Key? key}) : super(key: key);

  @override
  _AllMatchesState createState() => _AllMatchesState();
}

class _AllMatchesState extends State<AllMatches> {
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
              Expanded(
                child: Text(dateTime.hour.toString().padLeft(2, '0') +
                    ":" +
                    dateTime.minute.toString().padLeft(2, '0')),
                flex: 1,
              ),
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Text(
                      m.homeTeam.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Image.network(
                      m.homeTeam.teamLogo,
                      height: 30.0,
                      width: 30.0,
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(m.getCurrentScore()),
                    Text(Status.getStatusMSG(m.statusCode))
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Image.network(
                      m.awayTeam.teamLogo,
                      height: 30.0,
                      width: 30.0,
                    ),
                    Text(
                      m.awayTeam.name,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
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
    return Container(
        child: FutureBuilder<List<Match>>(
      future: AllMatchesLoader.fetchAllMatches(),
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
}
