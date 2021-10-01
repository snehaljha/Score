import 'dart:js';

import 'package:Score/Loader/TopTeamsLoader.dart';
import 'package:Score/Loader/json_loader.dart';
import 'package:Score/Model/Team.dart';
import 'package:Score/Model/category.dart';
import 'package:Score/Pages/Club/ClubPage.dart';
import 'package:Score/Pages/LeaguesView.dart';
import 'package:Score/Pages/menu.dart';
import 'package:flutter/material.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  Container getTopTeamsPage(ct) {
    return Container(
      child: FutureBuilder<List<Team>>(
        future: TopTeamsLoader.fetchTopTeams(),
        builder: (BuildContext context, AsyncSnapshot<List<Team>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("Loading..."),
            );
          }
          return getTeamsList(snapshot.data!, ct);
        },
      ),
    );
  }

  ListView getTeamsList(List<Team> teams, ct) {
    List<Widget> members = [];
    for (Team team in teams) {
      members.add(Card(
        child: InkWell(
          onTap: () {
            Navigator.push(
                ct, MaterialPageRoute(builder: (ct) => ClubPage(team: team)));
          },
          child: Container(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(3.0),
                  child: Image.network(
                    team.teamLogo,
                    height: 30,
                    width: 30,
                  ),
                ),
                Expanded(child: Text(team.name)),
                Icon(
                  Icons.favorite,
                  color: Colors.black,
                )
              ],
            ),
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Explore"),
          bottom: TabBar(
            tabs: [Tab(child: Text("All")), Tab(child: Text("Top Teams"))],
          ),
        ),
        drawer: Drawer(
          child: Menu(),
        ),
        body: TabBarView(
          children: [
            Container(
                child: FutureBuilder<List<Category>>(
              future: CategoriesLoader.fetchCategories(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Category>> snapshot) {
                if (snapshot.hasData) {
                  List<Category> cats = snapshot.data!;
                  cats.sort();
                  return ListView.builder(
                    itemCount: cats.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contex) =>
                                        LeaguesView(category: cats[index])));
                          },
                          child: Container(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Image.network(
                                  cats[index].flagUrl,
                                  width: 35,
                                  height: 35,
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Text(cats[index].name)
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return Container(
                    child: Center(child: Text("Cats cant be loaded")));
              },
            )),
            getTopTeamsPage(context)
          ],
        ),
      ),
    );
  }
}
