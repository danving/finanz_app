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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("Übersicht"),
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
          ],
        )
      ),
      drawer: drawerWidget(context),
      bottomNavigationBar: bottomNavBarWidget(context),
    );
  }
}
