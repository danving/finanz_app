import 'package:finanz_app/screens/category_food_screen.dart';
import 'package:finanz_app/widgets/appBar_widget.dart';
import 'package:finanz_app/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategorysScreen2 extends StatefulWidget {
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
            categoryList("Arbeit", "assets/svg/briefcase.svg"),
            categoryList("Haushalt", "assets/svg/home.svg"),
            categoryList("Mobilität", "assets/svg/car.svg"),
            categoryList("Reisen", "assets/svg/airport.svg"),
            categoryList("Uni", "assets/svg/school.svg"),
            categoryList("Kleidung", "assets/svg/cloth.svg"),
            categoryList("Essen", "assets/svg/food.svg"),
            categoryList("Freizeit", "assets/svg/party.svg"),
            categoryList("Medien", "assets/svg/media.svg"),
            categoryList("Geschenke", "assets/svg/present.svg"),
          ],
        ),
      ),
      drawer: drawerWidget(context),
    );
  }

  Widget categoryList(title, image) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FoodCategoryScreen()),
          );
        },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: SvgPicture.asset(
              image,
              width: 75,
              height: 75,
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
