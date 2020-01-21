import 'package:finanz_app/model/data_model.dart';

import 'package:finanz_app/screens/home_screen.dart';
import 'package:finanz_app/screens/overview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


final pages = <Widget> [
  HomeScreen(),
  OverviewScreen(),
];

Widget bottomNavBarWidget(context) {
  return BottomNavigationBar(
    items: DataModel.items,
    type: BottomNavigationBarType.fixed,
    currentIndex: DataModel.currentIndex,
    selectedItemColor: Colors.teal, //ToDo
    onTap: (int index) {
      DataModel.currentIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DataModel.pages[index]),
      );
    },
  );
}

