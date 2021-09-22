import 'package:flutter/material.dart';

import 'all_matches.dart';
import 'fav_matches.dart';
import 'menu.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [Text("Today's Fixture"), Text("My Fixtures")],
            ),
            title: Text("Home"),
          ),
          drawer: Drawer(
            child: Menu(),
          ),
          body: TabBarView(
            children: [AllMatches(), FavMatches()],
          )),
    );
  }
}
