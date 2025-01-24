import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> downloadImage(String url, BuildContext context) async {
  try {
    // Check if storage permission is granted
    bool permissionGranted = await checkPermission();
    if (!permissionGranted) {
      return;
    }

    final dio = Dio();

    // Get the external storage directory (e.g., Downloads folder)
    final directory = await getExternalStorageDirectory();

    // Build the path to the Downloads folder
    final downloadsPath =
        '${directory?.parent.parent.parent.parent.path}/Download';

    // Define the file path for saving the image
    final filePath =
        '$downloadsPath/image_${DateTime.now().millisecondsSinceEpoch}.jpg';

    // Download the image
    await dio.download(url, filePath);
    // ignore: use_build_context_synchronously
    showSnackbar(context, "Image downloaded to File Downloads");
  } catch (e) {
    print("Error downloading image: $e");
  }
}

// Helper method to check permission
Future<bool> checkPermission() async {
  if (Platform.isAndroid) {
    if (!await requestPermission(Permission.storage) &&
        !await requestPermission(Permission.manageExternalStorage)) {
      return false;
    }
  } else {
    if (!await requestPermission(Permission.storage)) {
      return false;
    }
  }
  return true;
}

// Request permission function
Future<bool> requestPermission(Permission permission) async {
  final status = await permission.status;
  if (!status.isGranted) {
    final permissionStatus = await permission.request();
    return permissionStatus.isGranted;
  }
  return true;
}

// to show Snackbar with Border Radius
void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        // Wrap the Text widget with Center to align it in the center
        child: Text(
          message,
          textAlign: TextAlign.center, // Ensures that the text is centered
        ),
      ),
      duration: const Duration(
          seconds: 4), // Duration for how long the Snackbar is visible
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Set the border radius here
      ),
      behavior: SnackBarBehavior
          .floating, // Makes the snackbar float above the bottom of the screen
      backgroundColor:
          Colors.black.withOpacity(0.7), // Optional: Customize background color
    ),
  );
}

