

import 'package:finanz_app/model/database.dart';
import 'package:finanz_app/model/eintrag.dart';
import 'package:finanz_app/widgets/appBar_widget.dart';
import 'package:finanz_app/widgets/bottomNavBar_Widget.dart';
import 'package:finanz_app/widgets/drawer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finanz_app/model/data_model.dart';



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _addKonto; //Eingabe Betrag
  TextEditingController _inputUsage;
  TextEditingController _initKonto; //Kontoinitialisierung


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
  ];

  dynamic tempCategory = "Wähle eine Kategorie";
  bool needInit = false; //Initialisierung notwendig?

  @override
  void initState() {
    _addKonto = new TextEditingController();
    _inputUsage = new TextEditingController();
    _initKonto = new TextEditingController();
    if (needInit) {
      //DBProvider.db.isEmty()
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => _displayInitDialog(context)); //TODO evtl.als mounted property?
    }
    super.initState();

  }




  @override
  void dispose() {
    _addKonto?.dispose();
    _inputUsage?.dispose();
    _initKonto?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("Hoffentlich reichts"),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                //Kontostandanzeige
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 10, left: 40, right: 40),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.teal[50],
                      border: Border.all(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: DataModel().getKontostand(context),
                    ),
                  ),
                ),
              ), //Kontostandanzeige
              Padding(
                //Betrag Eingabe
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 10, left: 40, right: 40),
                child: Center(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _addKonto,
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: "Betrag",
                      hintText: "00.00",
                    ),
                  ),
                ),
              ), //Betrag Eingabe
              Padding(
                //Eingabe Verwendungszweck
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 10, left: 40, right: 40),
                child: Center(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: _inputUsage,
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: "Verwendungszweck",
                      hintText: "Wocheneinkauf", //ToDo
                    ),
                  ),
                ),
              ),
              Padding(
                //Dropdown
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 10, left: 40, right: 40),
                child: Center(
                  child: DropdownButton<String>(
                    hint: Text("Wähle eine Kategorie"),
                    value: tempCategory,
                    onChanged: (String newValue) {
                      tempCategory = newValue; //test
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

              /*Padding(
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
              ),*/ //NOT USED

              Padding(
                padding: const EdgeInsets.only(
                    top: 30.0, bottom: 10, left: 40, right: 40),
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
                            "06.05.2018");
                        await DBProvider.db.newEintrag(tempEintrag);

                        /*DataModel.konto.addEintrag(new Eintrag(
                            ++counter,
                              false,
                              num.parse(_addKonto.text),
                              tempCategory,
                              _inputUsage.text,
                              new DateTime.now()));*/

                        setState(() {
                          tempCategory = "Wähle eine Kategorie";
                          _addKonto.clear();
                          _inputUsage.clear();
                        });
                        //Navigator.pop(context);
                      },
                      child: new Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 50.0,
                      ),
                      shape: new CircleBorder(),
                      elevation: 6.0,
                      fillColor: Colors.green[600],
                      padding: const EdgeInsets.all(15.0),
                    ),
                    Spacer(),
                    RawMaterialButton(
                      onPressed: () async {
                        Eintrag tempEintrag = new Eintrag(
                            true,
                            num.parse(_addKonto.text) * -1,
                            tempCategory,
                            _inputUsage.text,
                            "06.05.2018");
                        await DBProvider.db.newEintrag(tempEintrag);
                        setState(() {
                          tempCategory = "Wähle eine Kategorie";
                          _addKonto.clear();
                          _inputUsage.clear();
                        });
                        //Navigator.pop(context);
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomRight,
                      child: RawMaterialButton(
                        child: new Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 25,
                        ),
                        shape: CircleBorder(),
                        elevation: 6.0,
                        padding: const EdgeInsets.all(10.0),
                        fillColor: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavBarWidget(context),
    );
  }

  _displayInitDialog(BuildContext context) async {
    //TODO wieder implementieren mit DB Abfrage
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
                onPressed: () async {
                  Eintrag tempEintrag = new Eintrag(
                      true,
                      num.parse(_initKonto.text),
                      "Initialisierung",
                      "Initialisierung",
                      "06.05.2018");
                  await DBProvider.db.newEintrag(tempEintrag);
                  setState(() {
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

/*  Widget button(icon, color1, color2, dialog, context) {
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

 */
