import 'package:finanz_app/model/data_model.dart';
import 'package:finanz_app/model/database.dart';
import 'package:finanz_app/model/eintrag.dart';
import 'package:finanz_app/widgets/appBar_widget.dart';
import 'package:finanz_app/widgets/bottomNavBar_Widget.dart';
import 'package:finanz_app/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class OverviewScreen extends StatefulWidget {
  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("Übersicht"),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Container(
                    //
                    // width: 350,
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
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 8.0, bottom: 10.0),
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
              ),
              Center(
                child: FutureBuilder<List<Eintrag>>(
                  future: DBProvider.db.getAllEintraege(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Eintrag>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
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

  Widget overviewCard (amount, category, usage, date){
    return Card(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left:12.0, right: 12.0, top:5.0, bottom: 5.0),
          child: Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(amount),
                ],
              ),
              Spacer(),
              Column(
                children: <Widget>[
                  Row(

                    children: <Widget>[
                      Text(category,)
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(usage,)
                    ],
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: <Widget>[
                  Text(date),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
