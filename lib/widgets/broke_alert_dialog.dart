import 'package:flutter/material.dart';

Widget brokeDialog(){
  return AlertDialog(
    title: Text("Konto überzogen!"),
    content: Text("Tja, das hat diesmal wohl nicht gereicht."),
    actions: <Widget>[
      FlatButton(
        onPressed: (){},
        child: Text("Schade."),
      ),
    ],
    elevation: 10.0,
    );
}

