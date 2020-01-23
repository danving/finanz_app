import 'package:finanz_app/screens/home_screen.dart';
import 'package:finanz_app/screens/overview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/categories_screen.dart';
import 'database.dart';

class DataModel{

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


  List<String> categories = [ //ToDo
    "Arbeit",
    "Haushalt",
    "Mobilität",
    "Reisen",
    "Uni",
    "Kleidung",
    "Essen",
    "Freizeit",
    "Medien",
    "Geschenke",
    "Sonstiges",
  ];

  static final pages = <Widget> [
    HomeScreen(),
    OverviewScreen(),
    CategoriesScreen() //ToDo
  ];

  Widget getKontostand(BuildContext context) {//Textelement zur Kontostandsanzeige
    return FutureBuilder<num>(
      future: DBProvider.db.getTotal(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<num> snapshot) {
        List<Widget> children;

        if (snapshot.hasData) {
          children = <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('${snapshot.data}' + " €", style: TextStyle(fontSize: 40)),
            )
          ];
        } else if (snapshot.hasError) {
          children = <Widget>[
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            )
          ];
        } else {
          children = <Widget>[
            SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting result...'),
            )
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }



}

