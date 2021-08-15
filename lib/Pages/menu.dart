import 'package:Score/Pages/explore.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  static const double padding = 8.0;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Image.asset("assets/images/menu_img.jpg"),
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          padding: const EdgeInsets.all(padding),
          child: InkWell(
            child: Row(
              children: [
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Text("Favorites"),
                )
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(padding),
          child: InkWell(
            child: Row(
              children: [
                Icon(Icons.tv),
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Text("Matches"),
                )
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(padding),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Explore()),
              );
            },
            child: Row(
              children: [
                Icon(Icons.explore),
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Text("Explore"),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
