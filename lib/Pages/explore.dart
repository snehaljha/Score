import 'package:Score/Loader/json_loader.dart';
import 'package:Score/Model/category.dart';
import 'package:Score/Pages/LeaguesView.dart';
import 'package:Score/Pages/menu.dart';
import 'package:flutter/material.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {

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
              builder:
                  (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
                if(snapshot.hasData) {
                  List<Category> cats = snapshot.data!;
                  cats.sort();
                  return ListView.builder(
                    itemCount: cats.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (contex)=>LeaguesView(category: cats[index])));
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
                return Container(child: Center(child: Text("Cats cant be loaded")));
                  },
            )),
            Container()
          ],
        ),
      ),
    );
  }
}
