import 'package:finanz_app/model/data_model.dart';
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
    prefs.setBool('alreadyComp', false); //False, umzu überprüfen, ob Abfrage bereits gemacht wurde
    prefs.setString('month', DateFormat('MM').format(DateTime.now())); // Monat bei Initialisierung des Kontostandes
  }

  compareMonth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tempAlreadyComp = prefs.getBool('alreadyComp');
    print(tempAlreadyComp);
    var prefMonth = prefs.getString('month');
    print(prefMonth);
    var currentMonth = DateFormat('MM').format(DateTime.now());
    print(currentMonth);
    if(prefMonth != currentMonth) { //Vergleich gespeicherter Monat mit Momentanen
      prefs.setBool('alreadyComp', false); //alreadyComp auf false, weil für den neuen Monat noch nicht überprüft wurde
      print(prefs.getBool('alreadyComp'));
      prefs.setString('month', DateFormat('MM').format(DateTime.now())); //Aktuellen Monat ins prefs speichern
      print(prefs.getString('month'));
      return tempAlreadyComp;
    } else {
      print("Falseee");
      print(tempAlreadyComp);
      return tempAlreadyComp;
    }
  }

  compare() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tempAlreadyComp = prefs.getBool('alreadyComp');
    var compStudent = -819; // Durchschnittliche, monatliche Ausgaben
    var compAusgabe = await DBProvider.db.getMinusTotal(); //Gesamte Ausgaben
    if(compAusgabe <= compStudent && compareMonth() == false){ //Wenn durchschnitts Ausgaben in diesem Monat überschritten werden
      print("geht rein");
      prefs.setBool('alreadyComp', true); // alreadyComp auf true, weil Dialog diesen Moant schon aufgerufen wurde
      return true;
    } else {
      print("geht nicht rein");
      return false;
    }
  }

/*
  //Vergleich, ob ein neuer Monat ist, damit Alert Dialog nochmals aufgerufen werden kann
  sameMonth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tempMonth = prefs.getString('month');
    print(tempMonth);
    print("jetztiger Monat");
    var tempComp = prefs.getBool('alreadyComp');
    print(tempComp);
    print("temp Comp voher");
    if(tempMonth != DateFormat('MM').format(DateTime.now())){
      prefs.setBool('alreadyComp', false);
      tempComp = prefs.getBool('alreadyComp');
      print(tempComp);
      print("tempComp nachher");
    }
    return tempComp;
  }

  compare() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double compStudent = -819;
    double compAusgabe = await DBProvider.db.getMinusTotal();
    var prefAlreadyComp = prefs.getBool('alreadyComp');
    if (compAusgabe <= compStudent && this.sameMonth() == false) {
      prefs.setBool('alreadyComp', true);
      print(prefs.getBool('alreadyComp'));
      print("nach Ausgabe");
      return true;
    } else {
      print("false!!!");
      return false;
    }
  }
*/
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
