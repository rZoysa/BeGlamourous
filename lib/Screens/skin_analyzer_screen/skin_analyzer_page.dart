import 'package:be_glamourous/components/cutom_app_bar.dart';
import 'package:be_glamourous/utils/dialogs/skin_analyzer_guide_dialog.dart';
import 'package:be_glamourous/utils/loaders/custom_loader_icon.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class SkinAnalyzerPage extends StatefulWidget {
  const SkinAnalyzerPage({super.key});

  @override
  State<SkinAnalyzerPage> createState() => _SkinAnalyzerPageState();
}

class _SkinAnalyzerPageState extends State<SkinAnalyzerPage> {
  CameraController? controller;
  List<CameraDescription>? cameras;
  Future<void>? initializeControllerFuture;
  int selectedCameraIdx = 1; //1 is front Camera

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  void showGuideDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const SkinAnalyzerGuideDialog();
      },
    );
  }

  Future<void> initializeCamera([CameraDescription? camera]) async {
    var cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }
    if (await Permission.camera.isGranted) {
      cameras = await availableCameras();
      selectedCameraIdx = cameras!.indexOf(camera ?? cameras!.last);
      controller =
          CameraController(cameras![selectedCameraIdx], ResolutionPreset.max);
      initializeControllerFuture = controller!.initialize().then((_) {
        if (mounted) setState(() {});
        showGuideDialog();
      });
    } else {
      print('Camera permission not granted');
    }
  }

  void switchCamera() {
    if (cameras == null || cameras!.isEmpty) return;
    selectedCameraIdx = (selectedCameraIdx + 1) % cameras!.length;
    controller?.dispose();
    initializeCamera(cameras![selectedCameraIdx]);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return const Center(
        child: CustomLoaderIcon(),
      );
    }
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(
        icon: const Icon(
          Icons.change_circle,
          color: Colors.white,
        ),
        onIconPressed: switchCamera,
      ),
      body: FutureBuilder<void>(
        future: initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(controller!);
          } else {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
        },
      ),
    );
  }
}