import 'package:finanz_app/model/eintrag.dart';
import 'package:finanz_app/widgets/appBar_widget.dart';
import 'package:finanz_app/widgets/bottomNavBar_Widget.dart';
import 'package:finanz_app/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:finanz_app/model/data_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _addKonto;
  TextEditingController _removeKonto;
  TextEditingController _initKonto;

  List<String> dropDownCategories = [
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
  ];
  String tempCategorie;

  bool needInit = false; //Initialisierung notwendig?

  @override
  void initState() {
    _addKonto = new TextEditingController();
    _removeKonto = new TextEditingController();
    _initKonto = new TextEditingController();
    if (needInit)
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => _displayInitDialog(context)); //TODO evtl.als mounted property?

    super.initState();
  }

  @override
  void dispose() {
    _addKonto?.dispose();
    _removeKonto?.dispose();
    _initKonto?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("Home"),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                width: 350,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  border: Border.all(
                    color: Colors.black,
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    //konto.toStringAsFixed(2),
                    DataModel.konto.getKontostand().toStringAsFixed(2) + " €",
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Row(
                children: <Widget>[
                  Spacer(),
                  button(Icons.add, Colors.white, Colors.green[600],
                      _displayAddDialog, context),
                  Spacer(),
                  button(Icons.remove, Colors.white, Colors.red,
                      _displayRemoveDialog, context),
                  Spacer(),
                ],
              ),
            )
          ],
        ),
      ),
      drawer: drawerWidget(context),
      bottomNavigationBar: bottomNavBarWidget(context),
    );
  }

  Widget button(icon, color1, color2, dialog, context) {
    return RawMaterialButton(
      onPressed: () => dialog(context),
      child: new Icon(
        icon,
        color: color1,
        size: 50.0,
      ),
      shape: new CircleBorder(),
      elevation: 6.0,
      fillColor: color2,
      padding: const EdgeInsets.all(15.0),
    );
  }

  _displayAddDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Einzahlung"),
            content: Column(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _addKonto,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: "Betrag",
                      hintText: "1234",
                    ),
                  ),
                ),
                Expanded(
                  child: DropdownButton(
                    //TODO DROPDOWN MENU
                    hint: Text("Wähle eine Kategorie"),
                    value: tempCategorie,
                    onChanged: (newValue) {
                      setState(() {
                        tempCategorie = newValue;
                      });
                    },
                    items: dropDownCategories
                        .map((location) => DropdownMenuItem<String>(
                            child: new Text(location), value: location))
                        .toList(),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Abbrechen"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Einzahlen"),
                onPressed: () {
                  setState(() {
                    DataModel.konto.addEintrag(new Eintrag(
                        false,
                        num.parse(_addKonto.text),
                        "Essen",
                        new DateTime.now()));
                    _addKonto.clear();
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  _displayRemoveDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Auszahlung"),
            content: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _removeKonto,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: "Betrag",
                      hintText: "1234",
                    ),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Abbrechen"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Ausgabe"),
                onPressed: () {
                  setState(() {
                    DataModel.konto.addEintrag(new Eintrag(
                        true,
                        num.parse(_removeKonto.text),
                        "Essen",
                        new DateTime.now()));
                    _removeKonto.clear();
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  _displayInitDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Willkommen..."),
            content: Column(
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
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Kontostand übernehmen"),
                onPressed: () {
                  setState(() {
                    DataModel.konto.addEintrag(new Eintrag(
                        false,
                        num.parse(_initKonto.text),
                        "Essen",
                        new DateTime.now()));
                    _initKonto.clear();
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
