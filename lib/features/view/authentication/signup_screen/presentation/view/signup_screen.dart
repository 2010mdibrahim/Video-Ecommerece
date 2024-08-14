import 'package:e_commerce/core/core/extensions/extensions.dart';
import 'package:e_commerce/features/view/authentication/signup_screen/presentation/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../../core/core/widget/blur_widget.dart';
import '../../../../../../core/utils/appStyle.dart';
import '../../../../../../core/utils/app_assets.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_sizes.dart';
import '../../../../../widget/custom_elevatedButton/custom_eleveted_button.dart';
import '../../../../../widget/custom_richtext/custom_richtext.dart';
import '../../../../../widget/custom_textfield/custom_textfield.dart';

class SignupScreen extends StatelessWidget {
   SignupScreen({super.key});
  var controller = Get.put(SignupController());
  @override
  Widget build(BuildContext context) {
    return Obx(()=> Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 106,
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.slightWhite,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: CustomSimpleText(
                          text: "Video",
                          textAlign: TextAlign.end,
                          fontSize: AppSizes.size40,
                          fontWeight: FontWeight.w600,
                          alignment: Alignment.bottomLeft,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: CustomSimpleText(
                        text: "E-commerce",
                        textAlign: TextAlign.end,
                        fontSize: AppSizes.size27,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      )),
                ),
                40.ph,
                Container(
                  height: MediaQuery.of(context).size.height * 0.76,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppColors.slightWhite,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(96),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        20.ph,
                        CustomSimpleText(
                          text: "Registration",
                          textAlign: TextAlign.start,
                          fontSize: AppSizes.size24,
                          fontWeight: FontWeight.w600,
                        ),
                        40.ph,
                        SizedBox(
                          height: 45,
                          child: CustomTextfield(
                            controller: controller.firstName.value,
                            hintText: "Enter first name",
                            lebelText: "First Name",
                          ),
                        ),
                        20.ph,
                        SizedBox(
                          height: 45,
                          child: CustomTextfield(
                            controller: controller.lastName.value,
                            hintText: "Enter last name",
                            lebelText: "Last Name",
                          ),
                        ),
                        20.ph,
                        SizedBox(
                          height: 45,
                          child: CustomTextfield(
                            controller: controller.emailController.value,
                            hintText: "Enter your email",
                            lebelText: "Email",
                          ),
                        ),
                        20.ph,
                        SizedBox(
                          height: 45,
                          child: Obx(
                                () => CustomTextfield(
                              controller: controller.passwordController.value,
                              hintText: "Enter your password",
                              lebelText: "Password",
                              needObscureText: true,
                              obscureText: controller.obscureTextPassword.value,
                              onPress: () {
                                controller.obscureTextPassword.value =
                                !controller.obscureTextPassword.value;
                              },
                            ),
                          ),
                        ),
                        20.ph,
                        SizedBox(
                          height: 45,
                          child: Obx(
                                () => CustomTextfield(
                              controller: controller.confirmPasswordController.value,
                              hintText: "Enter your password again",
                              lebelText: "Confirm Password",
                              needObscureText: true,
                              obscureText: controller.obscureTextConfirmPassword.value,
                              onPress: () {
                                controller.obscureTextConfirmPassword.value =
                                !controller.obscureTextConfirmPassword.value;
                              },
                            ),
                          ),
                        ),
                        20.ph,
                        CustomSimpleText(
                          text: "Forget Password?",
                          alignment: Alignment.centerRight,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        40.ph,
                        CustomElevatedButton(
                          hexColor: HexColor('#072844'),
                          text: "Sign up",
                          onPress: () {},
                        ),
                        10.ph,
                        CustomRichText(
                          title: "Sign in",
                          titleTextColor: AppColors.orange,
                          heading: "Already have an account? ",
                          headingFontSize: AppSizes.size11,
                          titleFontSIze: AppSizes.size11,
                          titleFontWeight: FontWeight.w500,
                          headingFontWeight: FontWeight.w500,
                          headingTextColor: AppColors.slightBlue,
                          onPress: (){
                            // RouteGenerator.pushNamedAndRemoveAll(context, Routes.signInPage);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 10,
              top: 50,
              child: Stack(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: CustomPaint(
                      foregroundPainter:
                      CircleBlurPainter(circleWidth: 30, blurSigma: 1.5),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Image.asset(
                          AppAssets.logoShadow,
                          height: 55,
                          width: 52,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
