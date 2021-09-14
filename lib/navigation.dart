import 'package:Score/Pages/LiveMatchesView.dart';
import 'package:flutter/material.dart';

import 'Pages/explore.dart';
import 'Pages/home.dart';

class Navigation {

  static int currentPage = -1;

  static void switchTo(int page, context) {
    if(page == currentPage) {
      Navigator.pop(context);
    }
    Navigator.pushReplacement(context, getPage(page, context)!);
    currentPage = page;
  }

  static MaterialPageRoute? getPage(int page, context) {
    switch(page) {
      case 1: return MaterialPageRoute(builder: (context) => HomePage());
      case 2: return MaterialPageRoute(builder: (context) => LiveMatchesView());
      case 3: return MaterialPageRoute(builder: (context) => Explore());
    }
    return null;
  }
}
