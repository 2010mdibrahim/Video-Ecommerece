import 'package:e_commerce/core/core/extensions/extensions.dart';
import 'package:e_commerce/features/view/homepage/presentation/controller/home_controller.dart';
import 'package:flutter/material.dart';

import '../../../../../core/di/app_component.dart';
import '../../../../../core/utils/appStyle.dart';

class InformationWidget extends StatelessWidget {
   InformationWidget({super.key});
var homeController = locator<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomRow(icon: Icons.person, text: homeController.fullNameController.value.text),
        10.ph,
        CustomRow(icon: Icons.phone_android_outlined, text: homeController.phoneNumberController.value.text),
        10.ph,
        CustomRow(icon: Icons.location_on, text: homeController.detailAddressController.value.text),
      ],
    );
  }
  Widget CustomRow({required IconData icon, required String text}){
    return Row(
      children: [
         Icon(icon, size: 20,),
        10.pw,
        CustomSimpleText(
            text: text),
      ],
    );
  }
}
