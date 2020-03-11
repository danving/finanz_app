import 'package:finanz_app/screens/camera_screen.dart';
import 'package:finanz_app/screens/home_screen.dart';
import 'package:finanz_app/screens/overview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/categories_screen.dart';
import 'database.dart';

class DataModel{
//Für die NavBar
  static int currentIndex = 0;//für BottomNavBar

  static final pages = <Widget> [
    HomeScreen(),
    OverviewScreen(),
    CategoriesScreen(),
    CameraScreen(),
  ];
//Ende für die NavBar

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



  Widget showAlertDialog(BuildContext context, title, content){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: Text("Uff.."),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

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
  Widget getKontostandCategory(BuildContext context, String category) {//Textelement zur Kontostandsanzeige
    return FutureBuilder<double>(
      future: DBProvider.db.getCategorySum(category), // a previously-obtained Future<String> or null
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

