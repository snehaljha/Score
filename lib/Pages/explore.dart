import 'dart:collection';

import 'package:Score/Loader/json_loader.dart';
import 'package:Score/Loader/leagues_loader.dart';
import 'package:Score/Model/League.dart';
import 'package:Score/Model/category.dart';
import 'package:Score/Pages/leagues_view.dart';
import 'package:Score/Pages/menu.dart';
import 'package:Score/constants.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<Category> categories = [];

  _ExploreState() {
    readCategories();
  }

  var child = null;

  readCategories() async {
    final List<Category> data = await CategoriesLoader.fetchCategories();
    setState(() {
      this.categories = data;
      // this.categories.sort((a, b) {
      //   if (b == null) return -1;
      //   if (a.priority > b.priority) return -1;
      //   if (a.priority < b.priority) return 1;
      //   return a.name.compareTo(b.name);
      // });
    });
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
            body: TabBarView(children: [
              Container(
                child: Column(
                  children: [
                    categories.length > 0
                        ? Expanded(
                            child: ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return GFAccordion(
                                  titleChild: InkWell(
                                    onTap: () async => {
                                      child = new LeaguesView(categories[index])
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          Image.network(
                                            categories[index].flagUrl,
                                            width: 35,
                                            height: 35,
                                          ),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          Text(categories[index].name)
                                        ],
                                      ),
                                    ),
                                  ),
                                  contentChild: child);
                            },
                          ))
                        : Container()
                  ],
                ),
              ),
              Container()
            ])));
  }
}
