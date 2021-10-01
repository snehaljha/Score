import 'package:Score/Loader/SquadLoader.dart';
import 'package:Score/Loader/TeamInfoLoader.dart';
import 'package:Score/Model/Player.dart';
import 'package:Score/Model/Team.dart';
import 'package:flutter/material.dart';

class ClubSquad extends StatelessWidget {
  late Team _team;
  late Player _coach;
  late String _stadiumName;

  ClubSquad({Key? key, required team}) : super(key: key) {
    this._team = team;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(2.0),
        child: FutureBuilder<List<Player>>(
          future: _fetchData(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Player>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text("Loading"),
              );
            }

            return _getContent(snapshot.data!);
          },
        ));
  }

  Future<List<Player>> _fetchData() async {
    _coach = await TeamInfoLoader.fetchManager(_team);
    _stadiumName = await TeamInfoLoader.fetchStadiumName(_team.id);
    return await SquadLoader.fetchSquad(_team);
  }

  ListView _getContent(List<Player> players) {
    return ListView(
      children: [
        Row(
          children: [
            Image.network(
              _team.teamLogo,
              height: 80,
              width: 80,
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  "images/stadium.png",
                  width: 40,
                  height: 40,
                ),
                Text(_stadiumName)
              ],
            )
          ],
        ),
        Text("Coach"),
        Card(
          child: Container(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Image.network(
                  _coach.photo,
                  width: 35,
                  height: 35,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(_coach.name),
              ],
            ),
          ),
        ),
        ..._getSquads(players)
      ],
    );
  }

  List<Widget> _getSquads(List<Player> players) {
    String currentPosition = "";
    List<Widget> items = [];
    for (Player player in players) {
      if (player.position != currentPosition) {
        items.add(Text(player.position));
        currentPosition = player.position;
      }
      items.add(_getPlayerCard(player));
    }

    return items;
  }

  Card _getPlayerCard(Player player) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            Text(player.shirtNumber.toString()),
            SizedBox(
              width: 5,
            ),
            Image.network(
              player.photo,
              width: 40,
              height: 40,
            ),
            SizedBox(
              width: 5,
            ),
            Text(player.name),
            new Spacer(),
            player.preferredFoot == null
                ? SizedBox.shrink()
                : Image.asset(
                    "images/" + player.preferredFoot! + "_foot.png",
                    width: 30,
                    height: 30,
                  )
          ],
        ),
      ),
    );
  }
}
