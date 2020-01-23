import 'package:flutter/material.dart';

Widget overviewCard (amount, category, usage, date){
  return Card(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.only(left:12.0, right: 12.0, top:5.0, bottom: 5.0),
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(amount),
              ],
            ),
            Spacer(),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(category,)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(usage,)
                  ],
                ),
              ],
            ),
            Spacer(),
            Column(
              children: <Widget>[
                Text(date),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}