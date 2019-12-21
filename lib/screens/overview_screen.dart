import 'package:finanz_app/model/data_model.dart';
import 'package:finanz_app/widgets/appBar_widget.dart';
import 'package:finanz_app/widgets/bottomNavBar_Widget.dart';
import 'package:finanz_app/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class OverviewScreen extends StatefulWidget {
  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  List<Widget> list = createList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("Übersicht"),
      body: SingleChildScrollView(
        child: Container(
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
            Center(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return list[index];
                },
              ),
            ),
          ],
        )),
      ),
      drawer: drawerWidget(context),
      bottomNavigationBar: bottomNavBarWidget(context),
    );
  }

  static List createList() {
    List<Widget> liste = new List<Widget>();
    for (int i = DataModel.konto.getCountEintraege() - 1; i >= 0; i--) {
      liste.add(createUebersichtEintrag(i));
    }
    return liste;
  }

  static Widget createUebersichtEintrag(int i) {
    return Card(
      child: ListTile(
          title: Text(
              DataModel.konto.eintraege[i].getBetrag().toStringAsFixed(2))),
    );
  }
}
