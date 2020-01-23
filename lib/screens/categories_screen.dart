import 'package:finanz_app/screens/category_screen.dart';
import 'package:finanz_app/widgets/appBar_widget.dart';
import 'package:finanz_app/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../model/data_model.dart';

class Cat{                //ToDo
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
      appBar: appBarWidget("Kategorien"),
      body: Container(
        child: ListView(
          children: <Widget>[
            categoryList(DataModel().categories[0], "assets/svg/briefcase.svg",DataModel().categories[0]), //ToDo
            categoryList(DataModel().categories[1], "assets/svg/home.svg",DataModel().categories[1]),
            categoryList(DataModel().categories[2], "assets/svg/car.svg",DataModel().categories[2]),
            categoryList(DataModel().categories[3], "assets/svg/airport.svg",DataModel().categories[3]),
            categoryList(DataModel().categories[4], "assets/svg/school.svg",DataModel().categories[4]),
            categoryList(DataModel().categories[5], "assets/svg/cloth.svg",DataModel().categories[5]),
            categoryList(DataModel().categories[6], "assets/svg/food.svg",DataModel().categories[6]),
            categoryList(DataModel().categories[7], "assets/svg/party.svg",DataModel().categories[7]),
            categoryList(DataModel().categories[8], "assets/svg/media.svg",DataModel().categories[8]),
            categoryList(DataModel().categories[9], "assets/svg/present.svg",DataModel().categories[9]),
            categoryList(DataModel().categories[10], "assets/svg/other.svg", DataModel().categories[10]), //ToDo other svg
          ],
        ),
      ),
      drawer: drawerWidget(context),
    );
  }

  Widget categoryList(title, image, modelString) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new CategoryScreen(cat: new Cat(modelString))), // ToDO
          );
        },
      child: Card(
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
