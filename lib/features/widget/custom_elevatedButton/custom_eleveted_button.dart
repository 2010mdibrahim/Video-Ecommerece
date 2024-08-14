import 'package:e_commerce/core/utils/appStyle.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../main.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color? color;
  final HexColor? hexColor;
  final VoidCallback? onPress;
  final String text;
  const CustomElevatedButton(
      {super.key, this.color, this.onPress, this.hexColor, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: hexColor ?? AppColors.backgroundColor,
        minimumSize: Size(MediaQuery.of(context).size.width * 0.6, 38),
        maximumSize: Size(MediaQuery.of(context).size.width * 0.6, 38),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
      ),
      onPressed: onPress,
      child: CustomSimpleText(
        text: text,
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 16,
        textAlign: TextAlign.center,
        alignment: Alignment.center,
      ),
    );
  }
}
