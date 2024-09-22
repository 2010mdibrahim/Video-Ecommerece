import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
class CustomMultilineText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final Color? color;
  final double? fontSize;
  final FontStyle? fontStyle;
  final TextAlign? alignment;
  final int? maxLine;
  const CustomMultilineText(
      {super.key,
      required this.text,
      this.fontWeight,
      this.color,
      this.fontSize,
      this.fontStyle,
      this.alignment,
      this.maxLine});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignment ?? TextAlign.justify,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      textDirection: TextDirection.ltr,
      style: TextStyle(
          color: color ?? Theme.of(context).textTheme.displayLarge?.color,
          fontWeight:
              fontWeight ?? Theme.of(context).textTheme.displayLarge?.fontWeight,
          fontSize: fontSize ?? Theme.of(context).textTheme.displayLarge?.fontSize,
          fontStyle:
              fontStyle ?? Theme.of(context).textTheme.displayLarge?.fontStyle),
    );
  }
}

class CustomSimpleText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final Color? color;
  final double? fontSize;
  final FontStyle? fontStyle;
  final TextAlign? alignment;
  final TextDecoration? textDecoration;
  final TextOverflow? textOverFlow;

  const CustomSimpleText({
    super.key,
    required this.text,
    this.fontWeight,
    this.color,
    this.fontSize,
    this.fontStyle,
    this.alignment,
    this.textDecoration,
    this.textOverFlow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignment ?? TextAlign.center,
      overflow: textOverFlow ?? TextOverflow.visible,
      style: TextStyle(
        color: color ?? Theme.of(context).textTheme.displayLarge?.color,
        fontWeight:
            fontWeight ?? Theme.of(context).textTheme.displayLarge?.fontWeight,
        fontSize: fontSize ?? 20,
        fontStyle:
            fontStyle ?? Theme.of(context).textTheme.displayLarge?.fontStyle,

        decoration: textDecoration,
      ),
    );
  }
}

class FieldTitleText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final Color? color;
  final double? fontSize;
  final FontStyle? fontStyle;
  final TextAlign? alignment;
  const FieldTitleText(
      {super.key,
      required this.text,
      this.fontWeight,
      this.color,
      this.fontSize,
      this.fontStyle,
      this.alignment});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignment ?? TextAlign.start,
      style: TextStyle(
          color: color.toString().isEmpty
              ? AppColors.white
              : color,
          fontWeight:
              fontWeight ?? Theme.of(context).textTheme.displayLarge?.fontWeight,
          fontSize: fontSize ?? 18,
          fontStyle:
              fontStyle ?? Theme.of(context).textTheme.displayLarge?.fontStyle),
    );
  }
}


class CustomRichText extends StatelessWidget {
  final String? title, text;
  const CustomRichText({super.key, this.title, this.text});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title,
        style: DefaultTextStyle.of(context).style,
        children:  <TextSpan>[
          TextSpan(
              text: text,
              style: const TextStyle(fontWeight: FontWeight.bold, )),

        ],
      ),
    );
  }
}
