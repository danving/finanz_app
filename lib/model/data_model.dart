import 'package:finanz_app/screens/home_screen.dart';
import 'package:finanz_app/screens/overview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'konto.dart';

class DataModel{
  static Konto konto = Konto(0.0);
  static int currentIndex = 0;
  static final items = <BottomNavigationBarItem> [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text("Home"),
    ),

    BottomNavigationBarItem(
      icon: Icon(Icons.view_list),
      title: Text("Übersicht"),
    ),
  ];

  static final pages = <Widget> [
    HomeScreen(),
    OverviewScreen(),
  ];

}
