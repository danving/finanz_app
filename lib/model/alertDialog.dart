import 'package:finanz_app/model/database.dart';
import 'package:flutter/material.dart';

class AlertDialogs {

  bool isbroke = false;

  Future<bool> boolbroke() async {
    var broke = await DBProvider.db.getTotal();
    if (broke < 0 && isbroke == false) {
      isbroke = true;
    }
    print(isbroke);
  }

  Future<void> isNotBroke() async {
    var notBroke = await DBProvider.db.getTotal();
    if (notBroke >= 0) isbroke = false;
  }


  Future<bool> compare() async {
    var compStudent = -819;
    var compAusgabe = await DBProvider.db.getMinusTotal();
    print(compAusgabe);
    if (compAusgabe <= compStudent) return true;
  }

  Widget showAlertDialog(BuildContext context, title, content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                child: Text("Uff.."),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }

}