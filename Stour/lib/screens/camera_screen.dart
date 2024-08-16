import 'dart:async';
import 'dart:io';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:stour/screens/ocr.dart';

void main() {
  runApp(const CameraAwesomeApp());
}

class CameraAwesomeApp extends StatelessWidget {
  const CameraAwesomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'camerAwesome',
      home: CameraPage(),
    );
  }
}

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _capturedImage;
  MediaCapture? _capture;

  String filePath(MediaCapture mediaCapture) {
    if (mediaCapture.status == MediaCaptureStatus.success) {
      return mediaCapture.captureRequest.when(
        single: (single) => single.file!.path,
        multiple: (multiple) => multiple.fileBySensor.values.first!.path,
      );
    } else {
      return "null found";
    }
  }

  StreamSubscription<MediaCapture?>? _captureStateSubscription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: CameraAwesomeBuilder.awesome(
          saveConfig: SaveConfig.photo(),
          onMediaTap: (mediaCapture) {
            print("Tapped");
          },
          topActionsBuilder: (state) {
            _captureStateSubscription ??=
                state.captureState$.listen((MediaCapture? mediaCapture) {
              if (mediaCapture != null) {
                setState(() {
                  _capture = mediaCapture;
                });

                // switch (mediaCapture.status) {
                //   case MediaCaptureStatus.success:
                //     // Image captured, perform additional code (e.g., get the file path)
                //     print("Image captured: ${filePath(mediaCapture)}");
                //     _showImageDialog(File(filePath(mediaCapture)));
                //     break;
                //   case MediaCaptureStatus.capturing:
                //     print("Capturing in progress...");
                //     break;
                //   case MediaCaptureStatus.failure:
                //     print("Capture failed!");
                //     break;
                // }
                switch (mediaCapture.status) {
                  case MediaCaptureStatus.success:
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return OCRScreen(
                            imagePath: filePath(mediaCapture),
                          );
                        },
                      ),
                    );
                    print("Image captured: ${filePath(mediaCapture)}");
                    break;
                  case MediaCaptureStatus.capturing:
                    print("Capturing in progress...");
                    break;
                  case MediaCaptureStatus.failure:
                    print("Capture failed!");
                    break;
                }
              }
            });
            return Container();
          },
        ),
      ),
    );
  }

  void _showImageDialog(File image) {
    if (image != null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Image.file(image),
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _captureStateSubscription?.cancel();
    super.dispose();
  }
}
