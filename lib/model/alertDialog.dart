import 'package:finanz_app/model/data_model.dart';
import 'package:finanz_app/model/database.dart';
import 'package:flutter/material.dart';

class AlertDialogs {
  Future<bool> boolbroke() async {
    var broke = await DBProvider.db.getTotal();
    if (broke < 0 && DataModel.isbroke == false) {
      DataModel.isbroke = true;
      return true;
    }
    return false;
  }

  Future<void> isNotBroke() async {
    var notBroke = await DBProvider.db.getTotal();
    if (notBroke >= 0) {
      DataModel.isbroke = false;
    }
  }

  Future<bool> compare() async {
    var compStudent = -819;
    var compAusgabe = await DBProvider.db.getMinusTotal();
    if (compAusgabe <= compStudent) return true;
    return false;
  }

  void showAlertDialog(BuildContext context, title, content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            content: Text(content),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 6.0,
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Uff..",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.teal,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
