import 'package:finanz_app/widgets/appBar_widget.dart';
import 'package:finanz_app/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class FoodCategoryScreen extends StatefulWidget {
  @override
  _FoodCategoryScreenState createState() => _FoodCategoryScreenState();
}

class _FoodCategoryScreenState extends State<FoodCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("Essen"),
      body: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
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
                    "Konto",
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 0.0, right: 0.0),
            child: Row(
              children: <Widget>[
                Text(
                  "Ausgaben",
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
         Flexible(
           child: ListView(
             children: <Widget>[
               foodList("Aldi", "20.00", "20.10.19"),
             ],
           ),
         ),
          Row(
            children: <Widget>[
              expenceButton(),
            ],
          ),
        ],
      ),
      drawer: drawerWidget(context),
    );
  }

  Widget expenceButton(){
    return RawMaterialButton(
      onPressed: () {
      },
      child: Icon(Icons.remove, color: Colors.white,),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      fillColor: Colors.red,
    );
  }

  Widget foodList(type, cost, date) {
    return Padding(
      padding: const EdgeInsets.only(left:8.0, top: 15.0, right: 8.0),
      child: Card(
        child: ListTile(
            leading: Text(type),
            title: Center(child: Text(cost + "€")),
            trailing: Text(date),
        ),
      ),
    );
  }
}
