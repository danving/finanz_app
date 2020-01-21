import 'package:finanz_app/screens/category_food_screen.dart';
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

class CategorysScreen2 extends StatefulWidget { //ToDo ändern in CategoriesScreen
  @override
  _CategorysScreen2State createState() => _CategorysScreen2State();
}

class _CategorysScreen2State extends State<CategorysScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("Kategorien"),
      body: Container(
        child: ListView(
          children: <Widget>[
            categoryList(DataModel().Categories[0], "assets/svg/briefcase.svg",DataModel().Categories[0]), //ToDo
            categoryList(DataModel().Categories[1], "assets/svg/home.svg",DataModel().Categories[1]),
            categoryList(DataModel().Categories[2], "assets/svg/car.svg",DataModel().Categories[2]),
            categoryList(DataModel().Categories[3], "assets/svg/airport.svg",DataModel().Categories[3]),
            categoryList(DataModel().Categories[4], "assets/svg/school.svg",DataModel().Categories[4]),
            categoryList(DataModel().Categories[5], "assets/svg/cloth.svg",DataModel().Categories[5]),
            categoryList(DataModel().Categories[6], "assets/svg/food.svg",DataModel().Categories[6]),
            categoryList(DataModel().Categories[7], "assets/svg/party.svg",DataModel().Categories[7]),
            categoryList(DataModel().Categories[8], "assets/svg/media.svg",DataModel().Categories[8]),
            categoryList(DataModel().Categories[9], "assets/svg/present.svg",DataModel().Categories[9]),
            categoryList(DataModel().Categories[10], "assets/svg/other.svg", DataModel().Categories[10]), //ToDo other svg
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
