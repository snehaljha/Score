import 'package:Score/Loader/TeamMatchesLoader.dart';
import 'package:Score/Model/Status.dart';
import 'package:Score/Model/Team.dart';
import 'package:flutter/material.dart';
import 'package:Score/Model/Match.dart';

class ClubMatches extends StatefulWidget {
  Team team;
  ClubMatches({Key? key, required this.team}) : super(key: key);

  @override
  _ClubMatchesState createState() => _ClubMatchesState(team);
}

class _ClubMatchesState extends State<ClubMatches> {
  Team team;

  _ClubMatchesState(this.team);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Match>>(
        future: TeamMatchesLoader.fetchTeamMatches(team.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("Loading..."),
            );
          }
          return getMatchList(snapshot.data!);
        },
      ),
    );
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
              Column(
                children: [
                  Text(m.homeScore!.current.toString() +
                      " - " +
                      m.awayScore!.current.toString()),
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
}
