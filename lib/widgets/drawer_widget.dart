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
            color: Colors.green[300],
          ),
        ),
        drawerList(context, "Home", HomeScreen()),
      ],
    ),
  );
}

Widget drawerList(context, name, link) {
  return ListTile(
    trailing: Icon(Icons.home),
    title: Text(name),
    onTap: () {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => link),
      );
    },
  );
}
