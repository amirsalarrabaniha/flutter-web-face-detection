import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:google_mediapipe_face_detection/google_mediapipe_face_detection.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'dart:ui' as ui;

import 'package:image_proccessing/show_image_page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  List<CameraDescription>? cameras;
  CameraController? cameraController;
  GoogleMediapipeFaceDetection? faceDetection;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    try {
      faceDetection = GoogleMediapipeFaceDetection();
      await faceDetection?.load();
      cameras = await availableCameras();
      if (cameras?.isEmpty ?? true) {
        throw 'Camera Empty';
      }
      cameraController = CameraController(
        cameras![0],
        ResolutionPreset.medium,
      );
      await cameraController?.initialize();
      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Detection example app'),
      ),
      body: Center(
        child: (cameraController != null &&
            (cameraController?.value.isInitialized ?? false))
            ? Stack(
          children: [
            Center(child: CameraPreview(cameraController!)),
            Center(
              child: Container(
                width: 300,
                height: 400,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                      width: 4,
                    ),
                    borderRadius: BorderRadius.circular(100)),
              ),
            ),
          ],
        )
            : const Text('Loading Camera...'),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () async {
            try {
              final capturedImage = await cameraController?.takePicture();
              if (capturedImage == null) {
                throw 'Empty Camera Image';
              }
              InputImage inputImage =
              InputImage.fromFilePath(capturedImage.path);
              ui.Rect res =
                  (await faceDetection?.processImage(inputImage))!.first;

              Uint8List ii = await capturedImage.readAsBytes();
              Uint8List iii = (await rootBundle.load('assets/images/cap.png'))
                  .buffer
                  .asUint8List();

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShowImage(ii, res, iii)),
              );
              debugPrint(res.toString());
            } catch (e) {
              debugPrint(e.toString());
              return;
            }
          },
          child: const Icon(Icons.face),
        ),
      ),
    );
  }
}
