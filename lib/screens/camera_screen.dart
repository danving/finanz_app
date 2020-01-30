import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CamSaveImg extends StatefulWidget {
  @override
  _CamSaveImgState createState() => _CamSaveImgState();
}

class _CamSaveImgState extends State<CamSaveImg> {
  CameraController _camController;
  Future<void> _initCamFuture;

  @override
  void initState() {
    super.initState();
    _initCam();
  }

  _initCam() async {
    final cameras = await availableCameras();
    final firstCam = cameras.first;

    _camController = CameraController(
      firstCam,
      ResolutionPreset.medium,
    );

    _initCamFuture = _camController.initialize();
  }

  @override
  void dispose() {
    _camController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Save Picture")),
      body: FutureBuilder<void>(
        future: _initCamFuture,
        builder: (context, snapshot) {

          return CameraPreview(_camController);

        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            await _initCamFuture;

            final path = join(
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );

            //await _camController.takePicture(path);
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}