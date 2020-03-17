import 'package:finanz_app/screens/camera_screen.dart';
import 'package:finanz_app/screens/home_screen.dart';
import 'package:finanz_app/screens/overview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../screens/categories_screen.dart';
import 'package:finanz_app/model/database.dart';
import 'database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataModel{
//für BottomNavBar
  static int currentIndex = 0;



  static final pages = <Widget>[
    HomeScreen(),
    OverviewScreen(),
    CategoriesScreen(),
    CameraScreen(),
  ];


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

  DateTime currentBackPressTime;


  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: "Zum Beenden der App nochmal den Zurück-Button drücken.",
        backgroundColor: Colors.blue,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,

      );
      return Future.value(false);
    }
    return Future.value(true);
  }


  Widget getKontostand(BuildContext context) {
    //Textelement zur Kontostandsanzeige
    return FutureBuilder<double>(
      future: DBProvider.db.getTotal(),
      // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
        List<Widget> children;

        if (snapshot.hasData) {
          children = <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                  '${snapshot.data}' + " €", style: TextStyle(fontSize: 40)),
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
              child: Text(
                  '${snapshot.data}' + " €", style: TextStyle(fontSize: 25)),
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
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Keine Einträge in dieser Kategorie'),
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

