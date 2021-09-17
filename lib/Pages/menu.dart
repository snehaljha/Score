import 'package:Score/Pages/explore.dart';
import 'package:Score/navigation.dart';
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
          child: InkWell(
            onTap: () {
              Navigation.switchTo(1, context);
            },
            child: Container(
              padding: const EdgeInsets.all(padding),
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
        ),
        Container(
          child: InkWell(
            onTap: () {
              Navigation.switchTo(2, context);
            },
            child: Container(
              padding: const EdgeInsets.all(padding),
              child: Row(
                children: [
                  Icon(Icons.tv),
                  Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    child: Text("Live Matches"),
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          child: InkWell(
            onTap: () {
              Navigation.switchTo(3, context);
            },
            child: Container(
              padding: const EdgeInsets.all(padding),
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
          ),
        )
      ],
    );
  }
}
