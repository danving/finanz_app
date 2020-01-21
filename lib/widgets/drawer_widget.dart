import 'package:finanz_app/screens/categories_screen.dart';
import 'package:finanz_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

Widget drawerWidget(context) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        DrawerHeader(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "Hoffentlich reichts",
              style: TextStyle(fontSize: 20,),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.teal,
          ),
        ),
        drawerList(context, "Home", HomeScreen(), Icon(Icons.home)),
        drawerList(context, "Kategorien", CategorysScreen2(), Icon(Icons.apps)),
      ],
    ),
  );
}

Widget drawerList(context, name, link, icon) {
  return ListTile(
    trailing: icon,
    title: Text(name),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => link),
      );
    },
  );
}
