import 'package:e_commerce/core/core/extensions/extensions.dart';
import 'package:e_commerce/core/utils/appStyle.dart';
import 'package:e_commerce/core/utils/app_assets.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/utils/app_sizes.dart';
import 'package:e_commerce/features/widget/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../widget/cached_image_network/custom_cached_image_network.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        title: "Wallet",
        appBarBackgroundColor: AppColors.backgroundColor,
        titleColor: AppColors.white,
        backiconColor: AppColors.white,
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppAssets.point,
                              height: 20,
                              width: 20,
                            ),
                            5.pw,
                            CustomSimpleText(
                              text: "35",
                              fontSize: AppSizes.size14,
                            ),
                          ],
                        ),
                        5.ph,
                        CustomSimpleText(
                          text: "Total Points",
                          alignment: Alignment.center,
                          fontSize: AppSizes.size15,
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
                                text: "Point History",
                                fontSize: AppSizes.size16,
                              ),
                              CustomSimpleText(
                                text: "View All",
                                fontSize: AppSizes.size11,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.transparent,
                          height: MediaQuery.of(context).size.height * 0.625,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    color: HexColor("F4F7FE"),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 12),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.76,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
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
                                                          text: "\$ 100 point",
                                                          fontSize:
                                                              AppSizes.size14,
                                                          color:
                                                              AppColors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ],
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
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
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
