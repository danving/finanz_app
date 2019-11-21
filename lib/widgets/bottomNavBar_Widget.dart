import 'package:finanz_app/screens/categorys_screen.dart';
import 'package:finanz_app/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

int _currentIndex = 0;
final pages = <Widget> [
  HomeScreen(),
  CategorysScreen(),
  HomeScreen(),
];

Widget bottomNavBarWidget() {
  return BottomNavigationBar(
    items: items,
    type: BottomNavigationBarType.fixed,
    currentIndex: _currentIndex,
    onTap: (int index) {
      _currentIndex = index;
    },
  );
}

final items = <BottomNavigationBarItem> [
  BottomNavigationBarItem(
    icon: Icon(Icons.home),
    title: Text("Home"),
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.apps),
    title: Text("Kategorien"),
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.create),
    title: Text("Notizen"),
  ),
];