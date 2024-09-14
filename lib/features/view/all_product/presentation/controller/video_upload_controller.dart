import 'dart:convert';
import 'dart:io';

import 'package:chunked_uploader/chunked_uploader.dart';
import 'package:e_commerce/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/services.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../../core/network/configuration.dart';
import '../../../../../core/source/dio_client.dart';
import '../../../../widget/custom_toast/custom_toast.dart';

mixin VideoUploadController on GetxController{
  PlatformFile? paths;
  var vedioPath = "".obs;
  var a = 0.0.obs;
  VideoData? videoData;
  var thumbnail = ''.obs;
  Future<void> chooseFile(BuildContext context) async {
    try {
      if (await Permission.storage.request().isGranted) {
      paths = (await FilePicker.platform.pickFiles(withReadStream: true,  type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions:['mp4'] ,))!.files.single;
      // checkComplete.value = false;

      print(paths);
      } else if (await Permission.storage.request().isPermanentlyDenied) {
        await openAppSettings();
      } else if (await Permission.storage.request().isDenied) {
        await Permission.storage.request();
      }
    } on PlatformException catch (e) {
      print('Unsupported operation$e');
    } catch (e) {
      print(e.toString());
    }
    vedioPath.value = paths?.path ?? '';
    videoData = await FlutterVideoInfo().getVideoInfo(vedioPath.value);
    print("a!.filesize");
    print(videoData!.filesize);
    print(vedioPath);
    if ((videoData?.filesize! ?? 0) > 214572800) {
      errorToast(context: context, msg: "Highlight video size should be less than or equal 200mb");
    }else{
      thumbnail.value = await videoThumbnail(vedioPath.value);
    }
    update();
  }
  upload({PlatformFile? filepath, required String type, int? fileSize, required BuildContext context, required id}) async {
    if (filepath == null) return;

    // Open file directly
    var file = File(filepath.path!);

    ChunkedUploader chunkedUploader = ChunkedUploader(
      d.Dio(
        d.BaseOptions(
          baseUrl: "http://erp.mahfuza-overseas.com/trending-house/api/video-upload",
          headers: {
            'Authorization': 'Bearer ${session.getToken}',
          },
        ),
      ),
    );

    try {
      d.Response? response = await chunkedUploader.upload(
        fileKey: "file",
        method: "POST",
        path: "http://erp.mahfuza-overseas.com/trending-house/api/video-upload",
        data: {
          "product_id": id,
          'thumbnail': await d.MultipartFile.fromFile(thumbnail.value, filename: 'thumbnail.png'),
          'video_url': await d.MultipartFile.fromFile(
            filepath.path!,
            filename: filepath.name,
          ),
        },
        onUploadProgress: (progress) {
          print(progress);
          progressingUploadingVideo(progress);
        },
        fileDataStream: file.openRead(), // Use the file's read stream
        fileName: type,
        fileSize: fileSize ?? 0,
      );
      var responseData = response?.data;

      if (responseData is Map<String, dynamic>) {
        print(responseData); // Print the entire response map

        if (responseData['status'] == 1) {
          paths = null;
          a.value = 0.0;
          successToast(context: context, msg: responseData['message']);
          print(responseData['message']);
          update();
        } else {
          errorToast(context: context, msg: 'Upload failed');
        }
      } else {
        // Handle unexpected response format
        print("Unexpected response format: $responseData");
        errorToast(context: context, msg: 'Unexpected response format');
      }
      // Handle response as needed...
    } catch (e) {
      print("This is the error $e");
      errorToast(context: context, msg: 'Please try again');
    }
  }

  Future<String> videoThumbnail(String? mediaFile) async {
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: mediaFile ?? '',
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG, // Changed to JPEG or PNG if required
      maxHeight: 64,
      quality: 75,
    );
    if (thumbnailPath != null) {
      final thumbnailFile = File(thumbnailPath);
      int thumbnailSize = await thumbnailFile.length();
      const int maxSizeInBytes = 2 * 1024 * 1024;
      if (thumbnailSize > maxSizeInBytes) {
        errorToast(context: navigatorKey.currentContext!, msg: "Thumbnail size should be less than 2 MB");
        return '';
      }
      thumbnail.value = thumbnailPath;
      print("Thumbnail size: ${thumbnailSize / (1024 * 1024)} MB"); // Print size in MB
      return thumbnailPath;
    }

    return '';
  }

  progressingUploadingVideo(double progress){
    // Update progress
    double clampedProgress = progress;
    a.value = clampedProgress;
    print("uploadController.a.value ${a.value}");
    if (progress == 1.0) {
      a.value = 0.0; // Reset progress
    }
    update();
  }
}