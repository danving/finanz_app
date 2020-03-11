import 'package:finanz_app/model/database.dart';
import 'package:finanz_app/model/eintrag.dart';
import 'package:finanz_app/widgets/appBar_widget.dart';
import 'package:finanz_app/widgets/bottomNavBar_Widget.dart';
import 'package:flutter/material.dart';
import 'package:finanz_app/model/data_model.dart';
import 'package:intl/intl.dart';
import 'camera_screen.dart';

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
    "Sonstiges"
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

  Future<bool> boolbroke() async{
    var broke = await DBProvider.db.getTotal();
    if(broke < 0) return true;
  }

  Future<bool> compare() async{
    var compStudent = -819;
    var compAusgabe = await DBProvider.db.getMinusTotal();
    if(compAusgabe >= compStudent)
      return true;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("Hoffentlich reichts", false),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex:1),
            Center(
              //Kontostandanzeige
              child: Padding(
                padding: const EdgeInsets.only(
                    top:0, bottom:0, left: 40, right: 40),
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
                  top:0, bottom: 0, left: 40, right: 40),
              child: Center(
                child: TextField(
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
                      borderSide: BorderSide(color:Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color:  Colors.teal[900],),
                    ),
                  ),
                ),
              ),
            ), //Betrag Eingabe
            Spacer(flex:1),
            Padding(
              //Eingabe Verwendungszweck
              padding: const EdgeInsets.only(
                  top: 0, bottom: 0, left: 40, right: 40),
              child: Center(
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: _inputUsage,
                  autofocus: false,
                  cursorColor:  Colors.teal[900],
                  decoration: InputDecoration(
                    labelText: "Verwendungszweck",
                    hintText: "Wocheneinkauf",
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color:Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color:  Colors.teal[900]),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(flex:1),
            Padding(
              //Dropdown
              padding: const EdgeInsets.only(
                  top: 0, bottom: 0, left: 40, right: 40),
              child: Center(
                child: DropdownButton<String>(
                  hint: Text("Wähle eine Kategorie",
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
            Spacer(flex:1),
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
                  Spacer(),
                  //TODO Aufruf brokeDialog(), wenn Konto ins Minus kommt
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

                      if(boolbroke() == true) {
                        DataModel().showAlertDialog(context, "Tja, reicht wohl nicht", "Du hast dein Konto überzogen und bist nun im Minus");
                      }
                      if(compare() == true) {
                        DataModel().showAlertDialog(context, "Durchschnittliche Ausgaben", "Du hast nun die monatlichen Durchschnittausgaben "
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
            Spacer(flex:1)
          ],
        ),
      ),
      bottomNavigationBar: bottomNavBarWidget(context),
    );
  }
}
