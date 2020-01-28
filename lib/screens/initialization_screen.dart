import 'package:finanz_app/model/database.dart';
import 'package:finanz_app/model/eintrag.dart';
import 'package:finanz_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class InitializationScreen extends StatefulWidget {
  @override
  _InitializationScreenState createState() => _InitializationScreenState();
}

class _InitializationScreenState extends State<InitializationScreen> {
  TextEditingController _initKonto; //Kontoinitialisierung

  @override
  void initState() {
    _initKonto = new TextEditingController();
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
        body: Container(
            child: Column(
      children: <Widget>[
        Expanded(
            child: Text(
                "Danke fürs Runterladen unserer App. Hoffentlich reichts...")),
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            controller: _initKonto,
            autofocus: true,
            decoration: InputDecoration(
              labelText: "Initial-Kontostand",
              hintText: "1000",
            ),
          ),
        ),
        FlatButton(
          child: Text("Kontostand übernehmen"),
          onPressed: () async {
            Eintrag tempEintrag = new Eintrag(true, num.parse(_initKonto.text),
                "Initialisierung", "Initialisierung", "06.05.2018");
            await DBProvider.db.newEintrag(tempEintrag);
            setState(() {
              _initKonto.clear();
            });
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
      ],
    )));
  }
}
