import 'dart:io';
import 'package:finanz_app/model/data_model.dart';
import 'package:finanz_app/screens/imgFull_screen.dart';
import 'package:finanz_app/widgets/appBar_widget.dart';
import 'package:finanz_app/widgets/bottomNavBar_Widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  String dir;
  List filesList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: DataModel().onWillPop,
      child: Scaffold(
        appBar: appBarWidget("Bon-Kamera", true),
        body: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 160,
              child: FutureBuilder<List>(
                  future: _listofFiles(),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.hasData) {
                      return showGallery(snapshot);
                    } else {
                      return Text("Keine Bilder vorhanden!");
                    }
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_a_photo),
          tooltip: 'Pick Image',
          backgroundColor: Colors.teal[300],
          onPressed: () async {
            openCamera();
          },
        ),
        bottomNavigationBar: bottomNavBarWidget(context),
      ),
    );
  }

  Widget showGallery(AsyncSnapshot<List> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.length,
        //reverse: true,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.all(2),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImgFullScreen(
                                snapshot: snapshot,
                                curIndex: index,
                              )));
                },
                child: FadeInImage(
                  placeholder: AssetImage("assets/images/loading.gif"),
                  image: FileImage(
                    snapshot.data[snapshot.data.length - index - 1],
                  ),
                ),
              ));
        });
  }

  Future<List> _listofFiles() async {
    dir = await createFolderInAppDocDir("images");
    setState(() {
      filesList =
          Directory("$dir").listSync(); //use your folder name insted of resume.
    });
    return filesList;
  }

  void openCamera() async {
    // using your method of getting an image
    final File image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 800, maxWidth: 600);
    // getting a directory path for saving
    //dir = await createFolderInAppDocDir("images");
    // copy the file to a new path
    await image.copy('$dir/image_' +
        DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) +
        '.jpg');
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
