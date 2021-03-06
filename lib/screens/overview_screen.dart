import 'package:finanz_app/model/alertDialog.dart';
import 'package:finanz_app/model/data_model.dart';
import 'package:finanz_app/model/database.dart';
import 'package:finanz_app/model/eintrag.dart';
import 'package:finanz_app/widgets/appBar_widget.dart';
import 'package:finanz_app/widgets/bottomNavBar_Widget.dart';
import 'package:finanz_app/widgets/overview_card.dart';
import 'package:flutter/material.dart';

class OverviewScreen extends StatefulWidget {
  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: DataModel().onWillPop,
      child: Scaffold(
        appBar: appBarWidget("Übersicht", false),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Anzeige des Gesamtkontostandes
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
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
                      //Abruf aus Datenbank
                      child: DataModel().getKontostand(context),
                    ),
                  ),
                ),
              ),
              //Anzeige der bisherigen Einträge
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 8.0, bottom: 10.0),
                  //Überschriften für die Spalten
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 2,
                          child: Text(
                            "Betrag",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Spacer(),
                      Expanded(
                          flex: 5,
                          child: Text(
                            "Kategorie",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Spacer(),
                      Expanded(
                          flex: 3,
                          child: Row(
                            children: <Widget>[
                              Spacer(),
                              Text(
                                "Datum",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              //Liste aller bisherigen Einnahmen und Ausgaben
              Expanded(
                child: Scrollbar(
                  child: Center(
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverFillRemaining(
                          child: FutureBuilder<List<Eintrag>>(
                            future: DBProvider.db.getAllEintraege(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Eintrag>> snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  reverse: false,
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Eintrag item = snapshot
                                        .data[snapshot.data.length - index - 1];
                                    return Dismissible(
                                      key: UniqueKey(),
                                      background: Container(color: Colors.red),
                                      onDismissed: (direction) {
                                        DBProvider.db.deleteClient(item.id);
                                        AlertDialogs().isNotBroke();
                                        setState(() {}); // Reload Kontostand
                                      },
                                      child: overviewCard(
                                          item.amount.toStringAsFixed(2),
                                          item.category,
                                          item.usage,
                                          item.date),
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: bottomNavBarWidget(context),
      ),
    );
  }
}