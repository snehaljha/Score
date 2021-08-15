import 'package:Score/Loader/json_loader.dart';
import 'package:Score/Model/country.dart';
import 'package:Score/Pages/menu.dart';
import 'package:flutter/material.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<Country> countries = [];

  _ExploreState() {
    readCountries();
  }

  readCountries() async {
    final data = await JSONLoader.readCountries();
    setState(() {
      this.countries = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore"),
      ),
      drawer: Drawer(
        child: Menu(),
      ),
      body: Container(
        child: Column(
          children: [
            countries.length > 0
                ? Expanded(
                    child: ListView.builder(
                    itemCount: countries.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Image.network(
                              countries[index].flagUrl,
                              width: 20,
                              height: 20,
                            ),
                            Text(countries[index].name)
                          ],
                        ),
                      );
                    },
                  ))
                : Container()
          ],
        ),
      ),
    );
  }
}
