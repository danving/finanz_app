import 'package:finanz_app/model/data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




Widget bottomNavBarWidget(context) {
  return BottomNavigationBar(
    items: DataModel.items,
    type: BottomNavigationBarType.fixed,
    currentIndex: DataModel.currentIndex,
    selectedItemColor: Colors.teal, //ToDo selected Item anpassen
    onTap: (int index) {

      DataModel.currentIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DataModel.pages[index]),
      );
    },
  );
}

