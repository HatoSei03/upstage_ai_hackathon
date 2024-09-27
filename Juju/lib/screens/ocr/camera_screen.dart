// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:juju/screens/ocr/ocr.dart';
import 'package:get/get.dart';

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
          onMediaTap: (mediaCapture) {},
          topActionsBuilder: (state) {
            _captureStateSubscription ??=
                state.captureState$.listen((MediaCapture? mediaCapture) {
              if (mediaCapture != null &&
                  mediaCapture.status == MediaCaptureStatus.success) {
                Get.to(
                  () => OCRScreen(
                    imagePath: filePath(mediaCapture),
                  ),
                  transition: Transition.zoom,
                );
              }
            });
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _captureStateSubscription?.cancel();
    super.dispose();
  }
}
