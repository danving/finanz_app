import 'package:finanz_app/model/database.dart';
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
  TextEditingController _addKonto; //Eingabe Betrag
  TextEditingController _inputUsage;

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
  @override
  void initState() {
    _addKonto = new TextEditingController();
    _inputUsage = new TextEditingController();
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
    return Scaffold(
      appBar: appBarWidget("Home"),
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
                      hintText: "00.00", //ToDo
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
            ],
          ),
        ),
      ),
      drawer: drawerWidget(context),
      bottomNavigationBar: bottomNavBarWidget(context),
    );
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
