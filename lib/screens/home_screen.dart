import 'package:finanz_app/model/alertDialog.dart';
import 'package:finanz_app/model/database.dart';
import 'package:finanz_app/model/eintrag.dart';
import 'package:finanz_app/widgets/appBar_widget.dart';
import 'package:finanz_app/widgets/bottomNavBar_Widget.dart';
import 'package:flutter/material.dart';
import 'package:finanz_app/model/data_model.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _addKonto; //Eingabe Betrag
  TextEditingController _inputUsage; //Eingabe Verwendungszweck


  List<String> dropDownCategories = [
    "Wähle eine Kategorie", //TODO ändern
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
    "Sonstiges"
  ];

  dynamic tempCategory = "Wähle eine Kategorie";

  @override
  void initState() {
    _addKonto = new TextEditingController(); //Controller für Ein-/ Ausgaben
    _inputUsage = new TextEditingController(); //COntroller für Verwendungszeck
    super.initState();
  }

  @override
  void dispose() {
    _addKonto?.dispose();
    _inputUsage?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: DataModel().onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBarWidget("Hoffentlich reichts", false),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                //Kontostandanzeige
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.teal[50],
                      border: Border.all(
                        color: Colors.white,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: DataModel().getKontostand(context),
                    ),
                  ),
                ),
              ), //Kontostandanzeige
              Spacer(flex: 1),
              Padding(
                //Betrag Eingabe
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, left: 30, right: 30),
                child: Center(
                  child: TextField(
                    maxLength: 5,
                    keyboardType: TextInputType.number,
                    controller: _addKonto,
                    autofocus: false,
                    cursorColor: Colors.teal[900],
                    decoration: InputDecoration(
                      labelText: "Betrag",
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
                ),
              ), //Betrag Eingabe
              Padding(
                //Eingabe Verwendungszweck
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, left: 30, right: 30),
                child: Center(
                  child: TextField(
                    maxLength: 12,
                    keyboardType: TextInputType.text,
                    controller: _inputUsage,
                    autofocus: false,
                    cursorColor: Colors.teal[900],
                    decoration: InputDecoration(
                      labelText: "Verwendungszweck",
                      hintText: "Wocheneinkauf",
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal[900]),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                //Dropdown
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, left: 30, right: 30),
                child: Center(
                  child: DropdownButton<String>(
                    hint: Text(
                      "Wähle eine Kategorie",
                      style: TextStyle(color: Color.fromRGBO(7, 95, 30, 1)),
                    ),
                    value: tempCategory,
                    onChanged: (String newValue) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        tempCategory = newValue;
                      });
                    },
                    items: dropDownCategories
                        .map((String value) => DropdownMenuItem<String>(
                            child: new Text(value), value: value))
                        .toList(),
                  ),
                ),
              ), //Dropdown
              Spacer(flex: 20),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, left: 40, right: 40),
                child: Row(
                  children: <Widget>[
                    Spacer(),
                    RawMaterialButton(
                      onPressed: () async {
                        Eintrag tempEintrag = new Eintrag(
                            false,
                            num.parse(_addKonto.text),
                            tempCategory,
                            _inputUsage.text,
                            DateFormat('dd.MM.yyyy kk:mm')
                                .format(DateTime.now()));
                        await DBProvider.db.newEintrag(tempEintrag);
                        AlertDialogs().isNotBroke();
                        setState(() {
                          tempCategory = "Wähle eine Kategorie";
                          _addKonto.clear();
                          _inputUsage.clear();
                        });
                      },
                      child: new Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 50.0,
                      ),
                      shape: new CircleBorder(),
                      elevation: 6.0,
                      fillColor: Colors.greenAccent[700],
                      padding: const EdgeInsets.all(15.0),
                    ),
                    Spacer(flex: 2),
                    RawMaterialButton(
                      onPressed: () async {
                        Eintrag tempEintrag = new Eintrag(
                            true,
                            num.parse(_addKonto.text) * -1,
                            tempCategory,
                            _inputUsage.text,
                            DateFormat('dd.MM.yyyy kk:mm')
                                .format(DateTime.now()));
                        await DBProvider.db.newEintrag(tempEintrag);

                        //todo Fehler beheben

                        if (await AlertDialogs().boolbroke() == true) {
                          AlertDialogs().showAlertDialog(
                              context,
                              "Tja, reicht wohl nicht",
                              "Du hast dein Konto überzogen und bist nun im Minus");
                        }

                        if (await AlertDialogs().compare() == true) {
                          AlertDialogs().showAlertDialog(
                              context,
                              "Durchschnittliche Ausgaben",
                              "Du hast nun die monatlichen Durchschnittausgaben "
                                  "eines Studenten von 819€ erreicht.");
                        }


                        setState(() {
                          tempCategory = "Wähle eine Kategorie";
                          _addKonto.clear();
                          _inputUsage.clear();
                        });
                      },
                      child: new Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 50.0,
                      ),
                      shape: new CircleBorder(),
                      elevation: 6.0,
                      fillColor: Colors.red,
                      padding: const EdgeInsets.all(15.0),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Spacer(flex: 20)
            ],
          ),
        ),
        bottomNavigationBar: bottomNavBarWidget(context),
      ),
    );
  }
}
