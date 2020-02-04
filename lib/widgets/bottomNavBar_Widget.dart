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
      BottomNavigationBarItem(
        icon: Icon(Icons.camera_alt),
        title: Text("Kamera"),
      ),
    ],
    type: BottomNavigationBarType.fixed,
    currentIndex: DataModel.currentIndex,
    selectedItemColor: Colors.teal[300], //ToDo selected Item anpassen
    onTap: (index) {
      DataModel.currentIndex = index;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => DataModel.pages[index]),
          (Route<dynamic> route) => false,
      );
    },
  );
}

