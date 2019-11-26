import 'package:finanz_app/widgets/appBar_widget.dart';
import 'package:finanz_app/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class CategorysScreen extends StatefulWidget {
  @override
  _CategorysScreenState createState() => _CategorysScreenState();
}

class _CategorysScreenState extends State<CategorysScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("Kategorien"),
      body: Container(
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(2),
          children: <Widget>[
            categoryCard(Colors.blue[200],"assets/images/workbag.png", "Arbeit"),
            categoryCard(Colors.brown[300], "assets/images/food.png", "Essen"),
            categoryCard(Colors.pink[400], "assets/images/shirt.png", "Kleidung"),
            categoryCard(Colors.amber[300], "assets/images/present.png", "Geschenke"),
          ],
        ),
      ),
      drawer: drawerWidget(context),
    );
  }

  Widget categoryCard(bgColor, image, title) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: 200,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: bgColor,
            elevation: 7,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        image,
                        width: 100,
                        height: 100,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                     title,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
