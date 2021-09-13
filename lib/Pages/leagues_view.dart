import 'package:Score/Loader/leagues_loader.dart';
import 'package:Score/Model/League.dart';
import 'package:Score/Model/category.dart';
import 'package:Score/constants.dart';
import 'package:flutter/material.dart';

class LeaguesView extends StatefulWidget {
  Category category;
  LeaguesView(this.category);

  @override
  _LeaguesViewState createState() => _LeaguesViewState(category);
}

class _LeaguesViewState extends State<LeaguesView> {
  Category category;
  _LeaguesViewState(Category this.category);
  List<League> leagues = [];

  Future<void> readLeagues() async {
    String url = Constants.league
        .replaceFirst("{category_id}", widget.category.id.toString());
    final List<League> data = await LeaguesLoader.fetchLeagues(url);
    setState(() {
      this.leagues = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        leagues.length > 0
            ? Expanded(
                child: ListView.builder(
                itemCount: leagues.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Image.network(
                            leagues[index].leagueLogoUrl,
                            height: 35,
                            width: 35,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(leagues[index].name)
                        ],
                      ),
                    ),
                  );
                },
              ))
            : Container()
      ],
    );
  }
}
