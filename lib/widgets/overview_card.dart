import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget overviewCard(amount, category, usage, date) {
  return Card(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.only(
            left: 12.0, right: 12.0, top: 5.0, bottom: 5.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  Text(amount),
                ],
              ),
            ),
            Spacer(),
            Expanded(
              flex: 5,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        category,
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        usage,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Spacer(),
                      Text(date.substring(0, 10), )],
                  ),
                  Row(
                    children: <Widget>[
                      Spacer(),
                      Text(date.substring(11, 16), )],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
