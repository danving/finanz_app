import 'package:finanz_app/screens/home_screen.dart';
import 'package:finanz_app/screens/initialization_screen.dart';
import 'package:finanz_app/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'model/data_model.dart';
import 'model/database.dart';
import 'model/eintrag.dart';

void main()  {
  DataModel dm = new DataModel();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: FutureBuilder<List<Eintrag>>(
          future: DBProvider.db.getAllEintraege(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Eintrag>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                return LoadingScreen();
              case ConnectionState.done:
                if (snapshot.data.length == 0) {
                  return InitializationScreen();
                }
            }
            return HomeScreen();
          }),
    );
  }
}
