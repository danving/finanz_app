import 'package:finanz_app/screens/category_screen.dart';
import 'package:finanz_app/widgets/appBar_widget.dart';
import 'package:finanz_app/widgets/bottomNavBar_Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../model/data_model.dart';

//Screen für Kategorienübersicht
class Cat{
  final String category;
  Cat(this.category);
}

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("Kategorien", false),
      body: Scrollbar(
        child: Container(
          //Liste aller Kategorien
          child: ListView(
            children: <Widget>[
              categoryList(DataModel().categories[0], "assets/svg/briefcase.svg",DataModel().categories[0],Colors.blueGrey[100]),
              categoryList(DataModel().categories[1], "assets/svg/home.svg",DataModel().categories[1], Colors.blue[100]),
              categoryList(DataModel().categories[2], "assets/svg/car.svg",DataModel().categories[2], Colors.cyan[100]),
              categoryList(DataModel().categories[3], "assets/svg/airport.svg",DataModel().categories[3],Colors.greenAccent[100]),
              categoryList(DataModel().categories[4], "assets/svg/school.svg",DataModel().categories[4], Colors.limeAccent[100]),
              categoryList(DataModel().categories[5], "assets/svg/cloth.svg",DataModel().categories[5], Colors.amberAccent[100]),
              categoryList(DataModel().categories[6], "assets/svg/food.svg",DataModel().categories[6],Colors.orange[100]),
              categoryList(DataModel().categories[7], "assets/svg/party.svg",DataModel().categories[7], Colors.deepOrange[100]),
              categoryList(DataModel().categories[8], "assets/svg/media.svg",DataModel().categories[8], Colors.red[100]),
              categoryList(DataModel().categories[9], "assets/svg/present.svg",DataModel().categories[9],Colors.pink[100]),
              categoryList(DataModel().categories[10], "assets/svg/other.svg", DataModel().categories[10], Colors.grey[100]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavBarWidget(context),
    );
  }

  //Weiterleitung zur Einzelansicht der Kategorien
  Widget categoryList(title, image, modelString, color) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new CategoryScreen(cat: new Cat(modelString))),
          );
        },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: SvgPicture.asset(
              image,
              width: 60,
              height: 60,
            ),
            title: Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
