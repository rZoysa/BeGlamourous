import 'dart:convert';

import 'package:be_glamourous/Screens/skin_analyzer_screen/analyze_result_page.dart';
import 'package:be_glamourous/components/cutom_app_bar.dart';
import 'package:be_glamourous/providers/screen_change_provider.dart';
import 'package:be_glamourous/services/auth_service.dart';
import 'package:be_glamourous/utils/dialogs/skin_analyzer_guide_dialog.dart';
import 'package:be_glamourous/utils/loaders/custom_loader_icon.dart';
import 'package:be_glamourous/utils/navigation/custom_navigation.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class SkinAnalyzerPage extends StatefulWidget {
  const SkinAnalyzerPage({super.key});

  @override
  State<SkinAnalyzerPage> createState() => SkinAnalyzerPageState();
}

class SkinAnalyzerPageState extends State<SkinAnalyzerPage> {
  CameraController? controller;
  List<CameraDescription>? cameras;
  Future<void>? initializeControllerFuture;
  int selectedCameraIdx = 1; // 1 is front Camera
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ScreenChangeProvider>(context, listen: false);
    provider.addListener(_handleScreenChange);
    if (provider.screenId == 1) {
      showGuideDialog();
    }
  }

  Future<void> showGuideDialog() async {
    // Show the dialog and wait for it to be dismissed
    final result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const SkinAnalyzerGuideDialog();
      },
    );

    // If the user pressed "Okay", initialize the camera
    if (result == true) {
      initializeCamera();
    }
  }

  void _handleScreenChange() {
    final provider = Provider.of<ScreenChangeProvider>(context, listen: false);
    if (provider.screenId == 1) {
      showGuideDialog();
    } else {
      disposeCamera();
    }
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
      });
    } else {
      Logger().e('Camera permission not granted');
    }
  }

  Future<void> captureImage() async {
  try {
    await initializeControllerFuture; // Ensure the camera is initialized
    final image = await controller!.takePicture(); // Capture the image

    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    // send the image to the Node API
    final result = await sendImageToNodeAPI(image);
    Logger().f(result);

    setState(() {
      isLoading = false;
    });

    // Handle the result (show it to the user, etc.)
    if (result != null && mounted) {
      Customnavigation.nextPage2(context, AnalyzeResultPage(result: result));
    }
  } catch (e) {
    Logger().e('Error capturing image: $e');
    setState(() {
      isLoading = false;
    });
  }
}


  Future<Map<String, dynamic>?> sendImageToNodeAPI(XFile image) async {
    try {
      final uri = Uri.parse(
          '$apiURL/api/analyze-image'); // Replace with your actual URL
      final request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath('image', image.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        return jsonDecode(responseBody);
      } else {
        Logger().e('Failed to upload image: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      Logger().e('Error uploading image: $e');
      showErrorSnackBar('Error uploading image: $e');
      return null;
    }
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  // void showResultDialog(Map<String, dynamic> result) {
  //   if (result['skin_quality_scores'] != null) {
  //     Map<String, double> skinQualityScores =
  //         Map<String, double>.from(result['skin_quality_scores']);
  //
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: const Text('Skin Quality Rating'),
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: skinQualityScores.entries.map((entry) {
  //               return Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text('${entry.key}:'),
  //                   Text(
  //                       '${entry.value.round()}%'), // Display the score on a scale of 100
  //                 ],
  //               );
  //             }).toList(),
  //           ),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: const Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   } else {
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: const Text('Error'),
  //           content: const Text('Unable to retrieve analysis results.'),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: const Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  void switchCamera() {
    if (cameras == null || cameras!.isEmpty) return;
    selectedCameraIdx = (selectedCameraIdx + 1) % cameras!.length;
    controller?.dispose();
    initializeCamera(cameras![selectedCameraIdx]);
  }

  void disposeCamera() {
    controller?.dispose(); // Dispose the camera controller
  }

  @override
  void dispose() {
    Provider.of<ScreenChangeProvider>(context, listen: false)
        .removeListener(_handleScreenChange);
    disposeCamera();
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
    body: Stack(
      children: [
        FutureBuilder<void>(
          future: initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  CameraPreview(controller!),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 55,
                    child: Image.asset(
                      'assets/images/face_outline.png',
                      width: MediaQuery.of(context).size.width * 1.2,
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: captureImage,
                      icon: const Icon(
                        Icons.camera,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: CupertinoActivityIndicator());
            }
          },
        ),
        // Loading overlay
        if (isLoading) 
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
              child: Center(
                child: CupertinoActivityIndicator(
                  color: Colors.white,
                  radius: 16,
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

}
