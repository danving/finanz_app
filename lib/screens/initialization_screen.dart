import 'package:finanz_app/model/alertDialog.dart';
import 'package:finanz_app/model/database.dart';
import 'package:finanz_app/model/eintrag.dart';
import 'package:finanz_app/screens/home_screen.dart';
import 'package:finanz_app/widgets/appBar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class InitializationScreen extends StatefulWidget {
  @override
  _InitializationScreenState createState() => _InitializationScreenState();
}

class _InitializationScreenState extends State<InitializationScreen> {
  TextEditingController _initKonto; //Kontoinitialisierung

  @override
  void initState() {
    _initKonto = new TextEditingController(); //Textcontroller für Eingabe des Kontostandes
    super.initState();
  }

  @override
  void dispose() {
    _initKonto?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarWidget("Hoffentlich Reicht's", false),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            //Vorstellungstext
            children: <Widget>[
              Text(
                "Hoffentlich Reicht's",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.teal,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 10, left: 10, right: 10),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Danke fürs Herunterladen unserer App 'Hoffentlich Reicht's. Die App soll dir helfen deine Finanzen, "
                      "mit allen  möglichen Ausgaben, im Überblick zu behalten. Im besten Fall soll sie dir sogar helfen am Ende "
                      "des Monats noch genügend Geld auf dem Konto zu haben, sodass du dich nicht nur von Nudeln mit Ketchup "
                      "ernähren musst. Viel Erfolg damit!",
                      textAlign: TextAlign.justify,
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, right: 20, left: 20),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Nun musst du nur noch deinen Kontostand initialisieren und dann kannst du loslegen:",
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              //Textfeld für Eingabe des Kontostandes
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      maxLength: 5,
                      inputFormatters: [WhitelistingTextInputFormatter(RegExp("[0-9.]"))],
                      keyboardType: TextInputType.number,
                      controller: _initKonto,
                      autofocus: false,
                      cursorColor: Colors.teal[900],
                      decoration: InputDecoration(
                        labelText: "Initial-Kontostand",
                        hintText: "100.00",
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.teal[900],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Button zum Übernehmen des eingegebenen Kontostandes
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  child: Text("Kontostand übernehmen"),
                  color: Colors.teal[50],
                  onPressed: () async {
                    //Erstellung eines Eintrags in der Datenbank
                    Eintrag tempEintrag = new Eintrag(
                        true,
                        num.parse(_initKonto.text),
                        "Initialisierung",
                        "Initialisierung",
                        DateFormat('dd.MM.yyyy kk:mm').format(DateTime.now()));
                    await DBProvider.db.newEintrag(tempEintrag);

                    await AlertDialogs().isBrokeToSP();//Speichern von Elementen in Shared Preferences
                    await AlertDialogs().compareToSP();//Speichern von Elementen in Shared Preferences
                    setState(() {
                      _initKonto.clear();
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
              ),
              Spacer(),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Created by Andreas Enns & Dan Vi Nguyen",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
