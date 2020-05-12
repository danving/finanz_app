import 'package:finanz_app/model/database.dart';
import 'package:finanz_app/screens/initialization_screen.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

Widget appBarWidget(title, backbutton, context) {
  return AppBar(
    automaticallyImplyLeading: backbutton, // Used for removing back buttoon.
    title: Text(title),
    backgroundColor: Colors.teal,
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.settings, color: Colors.white),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Einstellungen"),
                  content: Text(
                    "Willst du alle bisherigen Einträge löschen und dein Konto neu initialisieren? (Deinen "
                    "echten Kontostand wird es allerdings nicht zurücksetzen..)",

                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 6.0,
                  actions: <Widget>[
                    Row(
                      children: <Widget>[
                        FlatButton(
                          child: Text(
                            "Lieber nicht.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.teal,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: Text(
                            "Ja, alles löschen!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.teal,
                            ),
                          ),
                          onPressed: () async {
                            await DBProvider.db.deleteAll();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        InitializationScreen()));

                          },

                        )
                      ],
                    )
                  ],
                );
              });
        },
      ),
    ],
  );
}
