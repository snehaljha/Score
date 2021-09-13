import 'package:flutter/material.dart';

import 'Pages/explore.dart';
import 'Pages/home.dart';

class Navigation {
  static int currentPage = -1;

  static void switchTo(int page, context) {
    // if (page == currentPage) return;
    // if (page == -11) {
    //   Navigator.pop(context);
    // } else if (currentPage != 0) {
    Navigator.push(context, push(page, context)!);
    // } else {
    //   Navigator.pop(context);
    //   Navigator.push(context, push(page, context)!);
    // }
    // currentPage = page;
  }

  static MaterialPageRoute? push(int page, context) {
    if (page == 1) {
      MaterialPageRoute(builder: (context) => HomePage());
    } else if (page == 2) {
      null;
    } else if (page == 3)
      return MaterialPageRoute(builder: (context) => Explore());
    return null;
  }
}
