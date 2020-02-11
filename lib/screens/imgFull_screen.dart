import 'dart:io';

import 'package:finanz_app/widgets/appBar_widget.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImgFullScreen extends StatelessWidget {
  AsyncSnapshot<List> snapshot;
  int ind;
  File file;

  ImgFullScreen({Key key, @required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("Bon-Kamera", true),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height - 135,
            child: PhotoViewGallery.builder(
              itemCount: snapshot.data.length,
              builder: (context, index) {
                ind = index;
                file = snapshot.data[ind];
                return PhotoViewGalleryPageOptions(
                  imageProvider: FileImage(
                    snapshot.data[index],
                  ),
                  // Contained = the smallest possible size to fit one dimension of the screen
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  // Covered = the smallest possible size to fit the whole screen
                  maxScale: PhotoViewComputedScale.covered * 2,
                );
              },
              scrollPhysics: BouncingScrollPhysics(),
              // Set the background color to the "classic white"
              backgroundDecoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .canvasColor,
              ),
              loadingChild: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          Container(
            height: 55,
            width: MediaQuery
              .of(context)
        .size
        .width,
            child: FlatButton(
              color: Colors.redAccent,
                onPressed: () {
                  file.deleteSync(recursive: true);
                  Navigator.pop(context);
                },
                child: Text("Bon löschen!")),
          ),
        ],
      )
      ,
    );
  }
}
