import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomTextfield extends StatelessWidget {
  final String hintText, lebelText;
  final TextEditingController controller;
  final bool? obscureText, needObscureText;
  final VoidCallback? onPress;
  const CustomTextfield(
      {super.key,
      required this.hintText,
      required this.lebelText,
      this.obscureText,
      this.onPress,
      this.needObscureText,
      required this.controller,
      });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText ?? false,
      controller: controller,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.only(left: 34.0),
          isDense: false,
          isCollapsed: false,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: HexColor("B1B1B1"), width: 1.5),
          ),
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              fontFamily: "Podkova",),
          hintTextDirection: TextDirection.ltr,
          label: Text(
            lebelText,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              fontFamily: "Podkova",
              color: Colors.black,
            ),
          ),
          alignLabelWithHint: true,
          fillColor: HexColor("#FFFFFFF"),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: HexColor("#B1B1B1"), width: 1.5),
            borderRadius: BorderRadius.circular(4),
          ),
          suffixIcon: needObscureText == true
              ? IconButton(
                  onPressed: onPress,
                  icon: Icon(
                    obscureText == false
                        ? Icons.visibility
                        : Icons.visibility_off,
                    size: 22,
                    color: Colors.black.withOpacity(0.6),
                  ))
              : const SizedBox.shrink(),),
    );
  }
}
