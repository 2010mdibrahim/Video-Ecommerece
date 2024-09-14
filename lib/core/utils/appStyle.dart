import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSimpleText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextAlign? textAlign;
  final AlignmentGeometry? alignment;
  final int? maxLines;
  const CustomSimpleText({super.key, required this.text, this.color, this.fontWeight, this.fontSize, this.textAlign, this.alignment, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.centerLeft,
      child: Text(
        text,
        maxLines: maxLines ?? 2,
        textAlign: textAlign ?? TextAlign.start,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.podkova(
          letterSpacing: 0.2,
          color: color ?? AppColors.backgroundColor,
          fontSize: fontSize ?? 14,
          fontWeight: fontWeight ?? FontWeight.w700,
        ),
      ),
    );
  }
}
