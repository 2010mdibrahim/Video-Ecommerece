import 'package:e_commerce/core/core/extensions/extensions.dart';
import 'package:e_commerce/core/utils/appStyle.dart';
import 'package:e_commerce/core/utils/app_assets.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/utils/app_sizes.dart';
import 'package:e_commerce/features/view/authentication/sign_in/presentation/controller/signin_controller.dart';
import 'package:e_commerce/features/widget/custom_elevatedButton/custom_eleveted_button.dart';
import 'package:e_commerce/features/widget/custom_richtext/custom_richtext.dart';
import 'package:e_commerce/features/widget/custom_text/custom_text.dart';
import 'package:e_commerce/features/widget/custom_textfield/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../../core/core/widget/blur_widget.dart';
import '../../../../../../core/di/app_component.dart';
import '../../../../../../core/routes/route_name.dart';
import '../../../../../../core/routes/router.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  var controller = locator<SigninController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
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
                            99.ph,
                            CustomSimpleText(
                              text: "Login",
                              textAlign: TextAlign.start,
                              fontSize: AppSizes.size24,
                              fontWeight: FontWeight.w600,
                            ),
                            60.ph,
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
                                  controller:
                                      controller.passwordController.value,
                                  hintText: "Enter your password",
                                  lebelText: "Password",
                                  needObscureText: true,
                                  obscureText: controller.obscureText.value,
                                  onPress: () {
                                    controller.obscureText.value =
                                        !controller.obscureText.value;
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
                            controller.isLoading.value == true
                                ? const CircularProgressIndicator()
                                : CustomElevatedButton(
                                    hexColor: HexColor('#072844'),
                                    text: "Sign in",
                                    onPress: () {
                                      controller.submitLoginData(context);
                                      // RouteGenerator.pushNamed(context, Routes.homepage);
                                    },
                                  ),
                            10.ph,
                            CustomRichText(
                              title: "Sign up",
                              titleTextColor: AppColors.orange,
                              heading: "Don't Have Account? ",
                              headingFontSize: AppSizes.size11,
                              titleFontSIze: AppSizes.size11,
                              titleFontWeight: FontWeight.w500,
                              headingFontWeight: FontWeight.w500,
                              headingTextColor: AppColors.slightBlue,
                              onPress: () {
                                RouteGenerator.pushNamed(
                                    context, Routes.signupPage);
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
                          foregroundPainter: CircleBlurPainter(
                              circleWidth: 30, blurSigma: 1.5),
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
