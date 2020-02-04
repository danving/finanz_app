import 'package:flutter/material.dart';

Widget appBarWidget(title, backbutton) {
  return AppBar(
    automaticallyImplyLeading: backbutton, // Used for removing back buttoon.
    title: Text(
        title),
    backgroundColor: Colors.teal,
  );
}