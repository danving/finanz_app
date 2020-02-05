import 'dart:io';
import 'package:finanz_app/widgets/appBar_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  String dir;
  List filesFileSystemEntity;

  @override
  void initState() {
    super.initState();
  }

  Future<List> _listofFiles() async {
    dir = await createFolderInAppDocDir("images");
    setState(() {
      filesFileSystemEntity =
          Directory("$dir").listSync(); //use your folder name insted of resume.
    });
    return filesFileSystemEntity;
  }

  void openCamera() async {
    // using your method of getting an image
    final File image = await ImagePicker.pickImage(source: ImageSource.camera);
    // getting a directory path for saving
    dir = await createFolderInAppDocDir("images");
    // copy the file to a new path
    await image.copy('$dir/image_' + DateFormat('ddMMyyyy_kkmm')
        .format(DateTime.now()) + '.jpg');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget("Kamera", true),
        body: Column(
          children: <Widget>[
            Container(
              height: 500,
              child:
                  FutureBuilder<List>(
                      future: _listofFiles(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List> snapshot) {
                        if (snapshot.hasData) {
                          return imagesGrid(context, snapshot);
                          //return Image.file(snapshot.data[0]);
                        } else {
                          return Text("(snapshot has no data)");
                        }
                      }),
            ),
            Container(
              height: 50,
              child: FlatButton(
                color: Colors.blueAccent,
                child: Text(
                  "Open Camera",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  openCamera();
                },
              ),
            ),
          ],
        ));
  }

  Widget imagesGrid(context, AsyncSnapshot<List> galleryItems) {
    return PhotoViewGallery.builder(
      itemCount: galleryItems.data.length,
      builder: (context, index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: FileImage(
            galleryItems.data[index],
          ),
          // Contained = the smallest possible size to fit one dimension of the screen
          minScale: PhotoViewComputedScale.contained * 0.8,
          // Covered = the smallest possible size to fit the whole screen
          maxScale: PhotoViewComputedScale.covered * 1,
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
    );
  }

  Widget testImg(AsyncSnapshot<List<File>> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                          image: FileImage(
                            snapshot.data[index],
                          ),
                          fit: BoxFit.cover))));
        });
  }


  Future<String> createFolderInAppDocDir(String folderName) async {
    //Get this App Document Directory
    final Directory _appDocDir = await getApplicationDocumentsDirectory();
    //App Document Directory + folder name
    final Directory _appDocDirFolder =
    Directory('${_appDocDir.path}/$folderName/');

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
      return _appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder =
      await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  }

}