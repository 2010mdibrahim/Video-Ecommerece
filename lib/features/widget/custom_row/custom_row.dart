import 'package:e_commerce/core/core/extensions/extensions.dart';
import 'package:e_commerce/core/utils/appStyle.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomRow extends StatelessWidget {
  final String title, icon;
  final Color titleColor;
  final VoidCallback? onPress;
  const CustomRow({super.key, required this.title, required this.icon, required this.titleColor, this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 39,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          gradient: LinearGradient(
            colors: [
              HexColor("FF7840").withOpacity(0.3),
              HexColor("1B436D").withOpacity(0.3),
            ],
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset(icon, height: 25, width: 25,),
            ),
            20.pw,
            CustomSimpleText(text: title, fontSize: 16, fontWeight: FontWeight.w500, color: titleColor,)
          ],
        ),
      ),
    );
  }
}
