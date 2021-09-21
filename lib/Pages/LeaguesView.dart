// import 'dart:html';

import 'package:Score/Loader/leagues_loader.dart';
import 'package:Score/Model/League.dart';
import 'package:Score/Model/category.dart';
import 'package:Score/Pages/LeagueView.dart';
import 'package:flutter/material.dart';

class LeaguesView extends StatefulWidget {
  LeaguesView({Key? key, required this.category}) : super(key: key);
  // LeaguesView(this.id);
  Category category;

  @override
  _LeaguesViewState createState() {
    return _LeaguesViewState(this.category);
  }
}

class _LeaguesViewState extends State<LeaguesView> {
  _LeaguesViewState(this.category);
  Category category;

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: Container(
        child: new FutureBuilder<List<League>>(
          future: LeaguesLoader.fetchLeagues(category.id),
          builder:
              (BuildContext context, AsyncSnapshot<List<League>> snapshot) {
            if (snapshot.hasData) {
              snapshot.data!.sort();
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LeagueView(league: snapshot.data![index])));
                      },
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Image.network(snapshot.data![index].leagueLogoUrl,
                                width: 30, height: 30),
                            SizedBox(width: 20.0),
                            Text(snapshot.data![index].name)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Container(
              child: Center(
                child: Text("Leaues can't be loaded"),
              ),
            );
          },
        ),
      ),
    );
  }
}
