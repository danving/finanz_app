import 'package:finanz_app/model/data_model.dart';
import 'package:flutter/material.dart';

Widget bottomNavBarWidget(context) {
  return BottomNavigationBar(
    //items: DataModel.items,
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text("Home"),
      ),

      BottomNavigationBarItem(
        icon: Icon(Icons.view_list),
        title: Text("Übersicht"),
      ),

      BottomNavigationBarItem(
        icon: Icon(Icons.category),
        title: Text("Kategorien"),
      ),
    ],
    type: BottomNavigationBarType.fixed,
    currentIndex: DataModel.currentIndex,
    selectedItemColor: Colors.green, //ToDo selected Item anpassen
    onTap: (index) {
      DataModel.currentIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DataModel.pages[index]),
      );
    },
  );
}

