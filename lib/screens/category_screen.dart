import 'package:finanz_app/model/database.dart';
import 'package:finanz_app/model/eintrag.dart';
import 'package:finanz_app/widgets/overview_card.dart';
import 'package:flutter/material.dart';
import '../model/data_model.dart';
import '../widgets/appBar_widget.dart';
import 'categories_screen.dart';

//Einzel-Kategorie-Ansichr
class CategoryScreen extends StatefulWidget {
  final Cat cat;

  CategoryScreen({Key key, @required this.cat}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(widget.cat.category, true),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              //Kontostandanzeige
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  alignment: Alignment.center,
                  height: 125,
                  decoration: BoxDecoration(
                    color: Colors.teal[50],
                    border: Border.all(
                      color: Colors.white,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: <Widget>[
                      // Anzeige Gesamtkontostand
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //Abruf aus Datenbank
                          DataModel().getKontostand(context),
                        ],
                      ),
                      //Anzeige Kontostand für spezifische Kategorie
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //Abruf aus Datenbank
                          DataModel().getKontostandCategory(
                              context, widget.cat.category)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //Anzeige der bisherigen Einträge
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 8.0, bottom: 10.0),
                //Überschriften der Spalten
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
            ), //Kontostandanzeige
            //Liste aller bisherigen Einnahmen und Ausgaben
            Expanded(
              child: Scrollbar(
                child: Center(
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverFillRemaining(
                        child: FutureBuilder<List<Eintrag>>(
                          future: DBProvider.db
                              .getAllEintraegeCategory(widget.cat.category),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Eintrag>> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                //reverse: false,
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Eintrag item = snapshot
                                      .data[snapshot.data.length - index - 1];
                                  //Wegwischen/ Löschen von Einträgen
                                  return Dismissible(
                                    key: UniqueKey(),
                                    background: Container(color: Colors.red),
                                    onDismissed: (direction) {
                                      DBProvider.db.deleteClient(item.id);
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
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
