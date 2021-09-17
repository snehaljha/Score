import 'package:Score/Pages/menu.dart';
import 'package:flutter/material.dart';

class LiveMatchesView extends StatefulWidget {
  const LiveMatchesView({ Key? key }) : super(key: key);

  @override
  _LiveMatchesViewState createState() => _LiveMatchesViewState();
}

class _LiveMatchesViewState extends State<LiveMatchesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        drawer: Drawer(
          child: Menu(),
        ),
        body: Container(
          child: Center(
            child: Text("Live Matches Page"),
          ),
        ),
      );
  }
}