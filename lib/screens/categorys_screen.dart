import 'package:finanz_app/widgets/appBar_widget.dart';
import 'package:finanz_app/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            categoryCard(Colors.white, "assets/svg/briefcase.svg", "Arbeit"),
            categoryCard(Colors.white, "assets/svg/home.svg", "Haushalt"),
            categoryCard(Colors.white, "assets/svg/car.svg", "Mobilität"),
            categoryCard(Colors.white, "assets/svg/airport.svg", "Reisen"),
            categoryCard(Colors.white, "assets/svg/school.svg", "Uni"),
            categoryCard(Colors.white, "assets/svg/cloth.svg", "Kleidung"),
            categoryCard(Colors.white, "assets/svg/food.svg", "Essen"),
            categoryCard(Colors.white, "assets/svg/party.svg", "Freizeit"),
            categoryCard(Colors.white, "assets/svg/media.svg", "Medien"),
            categoryCard(Colors.white, "assets/svg/present.svg", "Geschenke"),
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
                      SvgPicture.asset(
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
