import 'package:finanz_app/widgets/appBar_widget.dart';
import 'package:finanz_app/widgets/bottomNavBar_Widget.dart';
import 'package:finanz_app/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double kontostand = 40.01;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: appBarWidget("Home"),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:50.0),
              child: Center(
                child: Container(
                  width: 350,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      kontostand.toStringAsFixed(2),
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:50.0),
              child: Row(
                children: <Widget>[
                  Spacer(),
                  button(Icons.add, Colors.white, Colors.greenAccent,_displayAddDialog, context),
                  Spacer(),
                  button(Icons.remove, Colors.white, Colors.red,_displayRemoveDialog, context),
                  Spacer(),
                ],
              ),
            )
          ],
        ),
      ),
      drawer: drawerWidget(context),
    );
  }
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
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: "Betrag", hintText: "1234",
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Abbrechen"),
              onPressed: (){
                Navigator.pop(context);
              },),
            FlatButton(
              child: Text("Einzahlen"),
              onPressed: (){
                Navigator.pop(context);
              },),
          ],
        );
      }
  );
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
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: "Betrag", hintText: "1234",
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Abbrechen"),
              onPressed: (){
                Navigator.pop(context);
              },),
            FlatButton(
              child: Text("Auszahlen"),
              onPressed: (){
                Navigator.pop(context);
              },),
          ],
        );
      }
  );
}
