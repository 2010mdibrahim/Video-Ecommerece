import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/core/extensions/extensions.dart';
import 'package:e_commerce/core/di/app_component.dart';
import 'package:e_commerce/core/source/dio_client.dart';
import 'package:e_commerce/core/utils/appStyle.dart';
import 'package:e_commerce/core/utils/app_assets.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/features/view/homepage/presentation/controller/home_controller.dart';
import 'package:e_commerce/features/view/my_video_screen/presentation/controller/my_video_controller.dart';
import 'package:e_commerce/features/view/reels/presentation/controller/reels_controller.dart';
import 'package:e_commerce/features/widget/cached_image_network/custom_cached_image_network.dart';
import 'package:e_commerce/features/widget/custom_row/custom_row.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../core/routes/route_name.dart';
import '../../../../../core/routes/router.dart';
import '../../../../widget/custom_calender/custom_table_calender.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});
  var reelsController = locator<ReelsController>();
  var myVideoController = locator<MyVideoController>();
  var homeController = locator<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slightWhite,
      appBar: AppBar(
        backgroundColor: AppColors.slightWhite,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Center(
            child: Image.asset(
              AppAssets.logo,
              height: 28,
              width: 28,
            ),
          ),
        ),
        title: const CustomSimpleText(
          text: "E-commerce",
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        actions: [
          IconButton(
              onPressed: () {
                RouteGenerator.pushNamed(context, Routes.addToCartListPage);
                // reelsController.getCartData();
                homeController.homeAddToCartFunction(from: '');
              },
              icon: Icon(Icons.shopping_cart_sharp, size: 30, color: AppColors.black,)),
          10.ph,
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                AppAssets.notification,
                height: 30,
                width: 30,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomSimpleText(
                        text: "Welcome",
                        fontWeight: FontWeight.w700,
                        fontSize: 28,
                        color: Colors.black,
                      ),
                      // 10.ph,
                      CustomSimpleText(
                        text: "Md. Mehedi Hasan",
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const CustomCachedImageNetwork(
                      imageUrl:
                          "https://static.vecteezy.com/system/resources/thumbnails/041/714/266/small_2x/ai-generated-professional-man-in-suit-with-arms-crossed-on-transparent-background-stock-png.png",
                      height: 53,
                      weight: 51,
                    ),
                  ),
                ],
              ),
              20.ph,
              Row(
                children: [
                  Expanded(
                    child: CustomRow(
                      title: "Wallet",
                      icon: AppAssets.wallet,
                      titleColor: HexColor("8C632A"),
                      onPress: () {
                        RouteGenerator.pushNamed(context, Routes.wallet);
                        homeController.myWalletFunction();
                      },
                    ),
                  ),
                  20.pw,
                  Expanded(
                    child: CustomRow(
                      title: "Withdraw",
                      icon: AppAssets.withdraw,
                      titleColor: HexColor("235FAE"),
                    ),
                  ),
                ],
              ),
              10.ph,
              Row(
                children: [
                  Expanded(
                    child: CustomRow(
                      title: "My Sales",
                      icon: AppAssets.mySales,
                      titleColor: HexColor("FD6F71"),
                    ),
                  ),
                  20.pw,
                  Expanded(
                    child: CustomRow(
                      title: "Total Income",
                      icon: AppAssets.totalIncome,
                      titleColor: HexColor("007B00"),
                    ),
                  ),
                ],
              ),
              10.ph,
              Column(
                children: [
                  Container(
                      // Set the width of the container
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            topLeft: Radius.circular(5)),
                      ),
                      child: CalendarScreen()),
                  Container(
                    height: 28,
                    decoration: BoxDecoration(
                      color: HexColor("F7F6F6"),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                      // boxShadow: const [
                      //   BoxShadow(
                      //     color: Colors.black26,
                      //     blurRadius: 8,
                      //     offset: Offset(0, 2),
                      //
                      //   ),
                      // ],
                    ),
                    child: const CustomSimpleText(
                      text: "Calender",
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.black,
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
              20.ph,
              Row(
                children: [
                  Expanded(
                    child: CustomRow(
                      title: "My Video",
                      icon: AppAssets.myVideo,
                      titleColor: HexColor("324F5F"),
                      onPress: () {
                        RouteGenerator.pushNamed(context, Routes.myVideo);
                        // myVideoController.myVideoList();
                      },
                    ),
                  ),
                  20.pw,
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        RouteGenerator.pushNamed(context, Routes.friend);
                        homeController.frientListFunction();
                      },
                      child: CustomRow(
                        title: "My Friend",
                        icon: AppAssets.myFriends,
                        titleColor: HexColor("B1483B"),
                      ),
                    ),
                  ),
                ],
              ),
              10.ph,
              Row(
                children: [
                  Expanded(
                    child: CustomRow(
                      onPress: () {
                        RouteGenerator.pushNamed(context, Routes.sendMoney);
                      },
                      title: "Send Money",
                      icon: AppAssets.sendMoney,
                      titleColor: HexColor("171D8F"),
                    ),
                  ),
                  20.pw,
                  Expanded(
                    child: CustomRow(
                      onPress: () {
                        print(session.getToken);
                        RouteGenerator.pushNamed(context, Routes.allProducts);
                      },
                      title: "All Product",
                      icon: AppAssets.allProduct,
                      titleColor: HexColor("FE255F"),
                    ),
                  ),
                ],
              ),
              20.ph,
              InkWell(
                onTap: () {
                  RouteGenerator.pushNamed(context, Routes.reelsScreen);

                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        AppAssets.video,
                        height: 71,
                        width: 71,
                      ),
                      const Positioned(
                          top: 0,
                          bottom: 0,
                          child: CustomSimpleText(
                            text: "Videos",
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
              ),
              20.ph,
            ],
          ),
        ),
      ),
    );
  }
}
