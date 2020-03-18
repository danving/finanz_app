import 'package:finanz_app/model/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlertDialogs {
//Shared Prefereces für die Abfrage, ob das Konto überzogen wurde
  isBrokeToSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isBroke', false); //False, um zu prüfen, ob das Konto bereits im Minus war
  }

  //Abfrage, ob Konto im Minus ist
  boolbroke() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var broke = await DBProvider.db.getTotal(); //Gesamtkontostand
    var isBroke = prefs.getBool('isBroke');
    if (broke < 0 && isBroke == false) { //Wenn Konto im Minus ist und vorher nicht im Minus war
      //isBroke auf true für nächtse Abfrage
      await prefs.setBool('isBroke', true);
      return true;
    }
    return false;
  }

  //Überprüfen, ob Konto wieder im Plus ist
  void isNotBroke() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var notBroke = await DBProvider.db.getTotal(); //Gesamtkontostand
    if (notBroke >= 0) {
      // isBroke wieder auf false, damit beim erneuten ins Minus der Alert Dialog aufgerufen wird
      await prefs.setBool('isBroke', false);
    }
  }

  //alreadyComp(are) als Shared Preferences
  compareToSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('month', "00"); // Monat bei Initialisierung des Kontostandes
  }

  compare() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var compStudent = -819; // Durchschnittliche, monatliche Ausgaben
    var compAusgabe = await DBProvider.db.getMinusTotal(); //Gesamte Ausgaben
    if(compAusgabe <= compStudent && (prefs.getString("month") != DateFormat('MM').format(DateTime.now()))){ //Wenn durchschnitts Ausgaben in diesem Monat überschritten werden
      prefs.setBool('alreadyComp', true); // alreadyComp auf true, weil Dialog diesen Moant schon aufgerufen wurde
      prefs.setString("month", DateFormat('MM').format(DateTime.now()));
      return true;
    }
      return false;
  }

  void showAlertDialog(BuildContext context, title, content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            content: Text(content),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 6.0,
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Uff..",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.teal,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
