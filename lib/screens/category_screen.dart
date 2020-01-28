import 'package:finanz_app/model/database.dart';
import 'package:finanz_app/model/eintrag.dart';
import 'package:finanz_app/widgets/overview_card.dart';
import 'package:flutter/material.dart';
import '../model/data_model.dart';
import '../widgets/appBar_widget.dart';
import 'categories_screen.dart';

class CategoryScreen extends StatelessWidget {
  final Cat cat;

  CategoryScreen({Key key, @required this.cat}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(cat.category),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                //Kontostandanzeige
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
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
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 8.0, bottom: 10.0),
                  child: Row(
                    children: <Widget>[
                      Text("Betrag"),
                      Spacer(),
                      Text("Kategorie"),
                      Spacer(),
                      Text("Datum"),
                    ],
                  ),
                ),
              ),//Kontostandanzeige
              Center(child: FutureBuilder<List<Eintrag>>(
                future: DBProvider.db.getAllEintraegeCategory(cat.category),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Eintrag>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        Eintrag item = snapshot.data[index];
                        return Dismissible(
                          key: UniqueKey(),
                          background: Container(color: Colors.red),
                          onDismissed: (direction) {
                            DBProvider.db.deleteClient(item.id);
                          },
                          child: overviewCard(item.amount.toStringAsFixed(2), item.category, item.usage, item.date),
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
