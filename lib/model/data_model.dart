import 'package:finanz_app/screens/camera_screen.dart';
import 'package:finanz_app/screens/home_screen.dart';
import 'package:finanz_app/screens/overview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/categories_screen.dart';
import 'database.dart';

class DataModel{
//für BottomNavBar
  static int currentIndex = 0;

  static final pages = <Widget> [
    HomeScreen(),
    OverviewScreen(),
    CategoriesScreen(),
    CameraScreen(),
  ];
//Ende für die NavBar

  //Liste für die Kategorien
  List<String> categories = [
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


// Anzeige des Kontostandes
  Widget getKontostand(BuildContext context) {//Textelement zur Kontostandsanzeige
    return FutureBuilder<double>(
      future: DBProvider.db.getTotal(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
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

  //Anzeige des Kontostands für die einzelnen Kategorien
  Widget getKontostandCategory(BuildContext context, String category) {
    return FutureBuilder<double>(
      future: DBProvider.db.getCategorySum(category),
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
        List<Widget> children;

        if (snapshot.hasData) {
          children = <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('${snapshot.data}' + " €", style: TextStyle(fontSize: 25)),
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

