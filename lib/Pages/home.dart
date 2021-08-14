import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: Drawer(
        child: Menu(),
      ),
      body: Center(
        child: Text(
          "Favorite Items",
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

}