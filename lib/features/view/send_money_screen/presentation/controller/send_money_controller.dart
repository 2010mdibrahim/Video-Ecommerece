import 'package:e_commerce/core/core/extensions/extensions.dart';
import 'package:e_commerce/core/utils/appStyle.dart';
import 'package:e_commerce/core/utils/app_assets.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/utils/app_sizes.dart';
import 'package:e_commerce/features/widget/custom_elevatedButton/custom_eleveted_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../widget/cached_image_network/custom_cached_image_network.dart';

class SendMoneyController extends GetxController {
  Future<void> confirmationDialog(BuildContext context) async {
    showDialog(

      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: CustomSimpleText(
            text: "Confirmation",
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.size18,
            color: AppColors.black,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: CustomSimpleText(
                  text: "Do you want to transfer money?",
                  fontSize: AppSizes.size12,
                  fontWeight: FontWeight.normal,
                  color: AppColors.black,
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: HexColor("F4F7FE"),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius:
                          BorderRadius.circular(100),
                          child:
                          const CustomCachedImageNetwork(
                            imageUrl:
                            "https://static.vecteezy.com/system/resources/thumbnails/041/714/266/small_2x/ai-generated-professional-man-in-suit-with-arms-crossed-on-transparent-background-stock-png.png",
                            height: 40,
                            weight: 40,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            mainAxisAlignment:
                            MainAxisAlignment
                                .center,
                            children: [
                              CustomSimpleText(
                                text:
                                "Md. Mehedi Hasan",
                                fontSize:
                                AppSizes.size14,
                                color:
                                AppColors.black,
                                fontWeight:
                                FontWeight.w500,
                              ),
                              CustomSimpleText(
                                text: "16, Dec 2024",
                                fontSize: AppSizes.size10,
                                fontWeight:
                                FontWeight.normal,
                                color: AppColors.black,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              5.ph,
              Row(
                children: [
                  CustomSimpleText(
                    text: "Total Amount: ",
                    fontSize: AppSizes.size13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                  CustomSimpleText(
                    text: "\$1,000",
                    fontSize: AppSizes.size13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.deepBlue,
                  ),
                ],
              ),
              20.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Expanded(
                   child: Container(
                     height: 35,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(5),
                       color: Colors.red.withOpacity(0.2)
                     ),
                     child: Center(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Image.asset(AppAssets.cancel, height: 10.3,),
                           10.pw,
                           CustomSimpleText(text: "Cancel", fontWeight:  FontWeight.bold, fontSize: AppSizes.size16, color: AppColors.red,)
                         ],
                       ),
                     ),
                   ),
                 ),
                  10.pw,
                  Expanded(
                   child: Container(
                     height: 35,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(5),
                       color: HexColor("007A1A").withOpacity(0.2)
                     ),
                     child: Center(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Image.asset(AppAssets.check, height: 10.3,),
                           10.pw,
                           CustomSimpleText(text: "Submit", fontWeight:  FontWeight.bold, fontSize: AppSizes.size16, color: AppColors.green,)
                         ],
                       ),
                     ),
                   ),
                 ),
                ],
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Less curved corners
          ),
        );
      },
    );
  }
}
