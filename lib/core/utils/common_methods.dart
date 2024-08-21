import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/utils/app_assets.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui' as ui;
import '../source/dio_client.dart';
class CommonMethods{
  static showToast(String message, color) {
    Fluttertoast.showToast(
      msg: message,
      textColor: color,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 4,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
    );
  }
  static cachedNetworkImage(String url, {double? height, double? width, BoxFit? fit}){
  return  CachedNetworkImage(
      imageUrl: "${session.getBaseUrl}$url",
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
      progressIndicatorBuilder:
          (context, url, downloadProgress) =>
          Transform.scale(
            scale: 0.5,
            child:
             Center(child: CircularProgressIndicator(backgroundColor: AppColors.allProductCardColor)),
          ),
      errorWidget: (context, url, error) =>
      const Icon(Icons.image),
    );
  }


  static Widget notFoundArc({String title = "Data is not available"}) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            AppAssets.NOT_FOUND_IMAGE,
            height: 100,
            width: 100,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(right: 22),
            child: Text(
              title,
              textDirection: ui.TextDirection.ltr,
              style:  TextStyle(
                color: AppColors.backgroundColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

}