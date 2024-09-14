import 'package:e_commerce/core/core/extensions/extensions.dart';
import 'package:e_commerce/core/utils/appStyle.dart';
import 'package:e_commerce/core/utils/app_assets.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/utils/app_sizes.dart';
import 'package:e_commerce/features/view/send_money_screen/presentation/controller/send_money_controller.dart';
import 'package:e_commerce/features/widget/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../core/routes/route_name.dart';
import '../../../../../core/routes/router.dart';
import '../../../../widget/cached_image_network/custom_cached_image_network.dart';
import '../widget/transfer_money_history_widget.dart';

class SendMoneyScreen extends StatelessWidget {
   SendMoneyScreen({super.key});
var controller = Get.put(SendMoneyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        title: "Send Money",
        textAlign: TextAlign.start,
        isTextCenter: false,
        appBarBackgroundColor: AppColors.backgroundColor,
        titleColor: AppColors.white,
        backiconColor: AppColors.white,
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body:  Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomSimpleText(
                          text: "\$ 1,53,250",
                          color: AppColors.white,
                          fontSize: AppSizes.size20,
                        ),
                        CustomSimpleText(
                          text: "Main Balance",
                          color: AppColors.deepGrey,
                          fontSize: AppSizes.size12,
                        ),
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const CustomCachedImageNetwork(
                        imageUrl:
                        "https://static.vecteezy.com/system/resources/thumbnails/041/714/266/small_2x/ai-generated-professional-man-in-suit-with-arms-crossed-on-transparent-background-stock-png.png",
                        height: 40,
                        weight: 40,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: 70,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: AppColors.white),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    20.ph,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomSimpleText(
                                text: "\$ 1,52,250",
                                fontSize: AppSizes.size20,
                                fontWeight: FontWeight.normal,
                                color: AppColors.black,
                                alignment: Alignment.center,
                              ),
                              CustomSimpleText(
                                text: "Transfer Amount",
                                alignment: Alignment.center,
                                fontSize: AppSizes.size14,
                                fontWeight: FontWeight.normal,
                                color: AppColors.black,
                              ),
                              5.ph,
                              InkWell(
                                onTap:()=> controller.confirmationDialog(context),
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: AppColors.black,
                                  ),
                                  child: Center(
                                    child: Icon(Icons.arrow_forward, color: AppColors.white, size: 17,),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        20.ph,
                        Divider(
                          color: AppColors.black.withOpacity(0.1),
                        ),
                        20.ph,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomSimpleText(
                                text: "Transfer History",
                                fontSize: AppSizes.size16,
                              ),
                              InkWell(
                                onTap: (){
                                  RouteGenerator.pushNamed(context, Routes.transferMoneyHistory);
                                },
                                child: CustomSimpleText(
                                  text: "View All",
                                  fontSize: AppSizes.size11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        5.ph,
                        Container(
                          color: Colors.transparent,
                          height: MediaQuery.of(context).size.height * 0.625,
                          child: TransferMoneyHistoryWidget(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
