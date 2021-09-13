import 'package:flutter/material.dart';

class AllMatches extends StatefulWidget {
  const AllMatches({Key? key}) : super(key: key);

  @override
  _AllMatchesState createState() => _AllMatchesState();
}

class _AllMatchesState extends State<AllMatches> {

  late DateTime now;
  _AllMatchesState() {
    this.now = new DateTime.now();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Date: " + now.day.toString() + ", Month: " + now.month.toString() + ", Year: " + now.year.toString()),
      ),
    );
  }
}
