import 'package:e_commerce/core/utils/appStyle.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../main.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color? textColor;
  final Color? hexColor; // Ensure hexColor is a Color, not a string
  final FontWeight? fontWeight;
  final VoidCallback? onPress;
  final String text;
  final double? topRightRadius,
      bottomLeftRadius,
      topLeft,
      bottomRight,
      minimumWidthSize,
      maximumWidthSize, textSize;
  const CustomElevatedButton({
    super.key,
    this.textColor,
    this.onPress,
    this.hexColor,
    required this.text,
    this.bottomLeftRadius,
    this.topRightRadius,
    this.bottomRight,
    this.topLeft,
    this.fontWeight,
    this.maximumWidthSize,
    this.minimumWidthSize,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: hexColor ??
            AppColors.backgroundColor, // This works if hexColor is a Color
        minimumSize: Size(
            minimumWidthSize ?? MediaQuery.of(context).size.width * 0.6, 38),
        maximumSize: Size(
            maximumWidthSize ?? MediaQuery.of(context).size.width * 0.6, 38),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(topRightRadius ?? 10),
            bottomLeft: Radius.circular(bottomLeftRadius ?? 10),
            topLeft: Radius.circular(topLeft ?? 0),
            bottomRight: Radius.circular(bottomRight ?? 0),
          ),
        ),
      ),
      onPressed: onPress,
      child: CustomSimpleText(
        text: text,
        color: textColor ?? Colors.white,
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: textSize ?? 16,
        textAlign: TextAlign.center,
        alignment: Alignment.center,
      ),
    );
  }
}
