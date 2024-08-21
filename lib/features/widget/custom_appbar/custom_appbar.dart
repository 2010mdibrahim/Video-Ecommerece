import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final String? fontFamily;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.onBackPressed,
    this.fontFamily
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.slightWhite,
      centerTitle: true,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style:GoogleFonts.podkova(
            letterSpacing: 0.2,
            color: Colors.black,
            fontSize: 20.0,
            fontWeight:  FontWeight.w600,
          )
      ),
      leading: onBackPressed != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: onBackPressed,
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
