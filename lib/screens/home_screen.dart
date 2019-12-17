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

  //num konto = 40.01;



  @override
  void initState() {
    _addKonto = new TextEditingController();
    _removeKonto = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _addKonto?.dispose();
    _removeKonto?.dispose();
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
                    DataModel.konto.getKontostand().toStringAsFixed(2),
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
            content: Row(
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
                    //konto += double.parse(_addKonto.text);
                    DataModel.konto.addEintrag(new Eintrag(false, num.parse(_addKonto.text), "Essen"));

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
                    //konto -= double.parse(_removeKonto.text);
                    DataModel.konto.addEintrag(new Eintrag(true, num.parse(_removeKonto.text), "Essen"));
                    _removeKonto.clear();
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

}
