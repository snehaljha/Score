import 'package:flutter/material.dart';

class FavMatches extends StatefulWidget {
  const FavMatches({Key? key}) : super(key: key);

  @override
  _FavMatchesState createState() => _FavMatchesState();
}

class _FavMatchesState extends State<FavMatches> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Favourite matches will be shown here"),
      ),
    );
  }
}
