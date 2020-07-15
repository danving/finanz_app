import 'dart:io';
import 'package:finanz_app/model/database.dart';
import 'package:finanz_app/widgets/appBar_widget.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'initialization_screen.dart';

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  TextEditingController _inputReset; // Eingabe Reset-Bestätigung

  @override
  void initState() {
    _inputReset = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _inputReset?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarWidget("Reset", true),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
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
                      "Willst du alle bisherigen Einträge und Bilder löschen und dein Konto neu initialisieren? (Deinen "
                      "echten Kontostand wird es allerdings nicht zurücksetzen..)",
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
                      "Wenn du wirklich alles zurücksetzten willst, dann gib 'LÖSCHEN' in das Textfeld ein.",
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      maxLength: 7,
                      keyboardType: TextInputType.text,
                      controller: _inputReset,
                      autofocus: false,
                      cursorColor: Colors.teal[900],
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal[900]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        "Nein, lieber nicht.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.teal,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Spacer(),
                    FlatButton(
                        child: Text(
                          "Ja, alles löschen!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.teal,
                          ),
                        ),
                        onPressed: () async {
                          resetApp(_inputReset.text);
                        }),
                  ],
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
                    Text(
                      "Icons by iconmonstr.com",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.teal,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resetApp(String delString) async {
    if (delString == 'LÖSCHEN') {
      await DBProvider.db.deleteAll(); // Löschen der Datenbank
      //Löschen des Bilderordners
      Directory dirToDel = await getApplicationDocumentsDirectory();
      dirToDel = Directory('${dirToDel.path}/images');
      if (await dirToDel.exists()) {
        dirToDel.deleteSync(recursive: true);
      }
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => InitializationScreen()));
    }
  }
}
