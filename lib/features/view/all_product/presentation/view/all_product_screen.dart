import 'package:e_commerce/core/utils/appStyle.dart';
import 'package:e_commerce/core/utils/app_assets.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/utils/app_sizes.dart';
import 'package:e_commerce/features/view/all_product/presentation/controller/all_product_controller.dart';
import 'package:e_commerce/features/widget/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../widget/all_products_widget.dart';
import '../widget/product_category_widget.dart';

class AllProductScreen extends StatelessWidget {
  AllProductScreen({super.key});
  var controller = Get.put(AllProductController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Obx(() => Scaffold(
            backgroundColor: AppColors.slightWhite,
            appBar: CustomAppBar(
              title: "All Products",
              onBackPressed: () {
                Navigator.pop(context);
              },
            ),
            body: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TabBar(
                      labelStyle: GoogleFonts.podkova(
                        letterSpacing: 0.2,
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                      dividerColor: Colors.transparent,
                      indicatorColor: Colors.transparent,
                      unselectedLabelColor: Colors.black,
                      splashFactory: NoSplash.splashFactory,
                      onTap: (value) {
                        controller.isSelected.value = value;
                      },
                      tabs: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 26,
                          decoration: BoxDecoration(
                            color: controller.isSelected.value == 0
                                ? HexColor("508A7B").withOpacity(0.5)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: controller.isSelected.value == 0 ? Colors.white : Colors.black26,
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppAssets.categoryIcon,
                                  height: 14.81,
                                  width: 14.81,
                                ),
                                CustomSimpleText(
                                  text: "Category",
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                            height: 26,
                            decoration: BoxDecoration(
                              color: controller.isSelected.value == 1
                                  ? HexColor("508A7B")
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppAssets.allProductIcon,
                                    height: 14.81,
                                    width: 14.81,
                                  ),
                                  CustomSimpleText(
                                    text: "All Product",
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              ),
                            ),),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TabBarView(
                        children: [
                          // Content for the first tab
                          ProductCategoryWidget(),
                          AllProductsWidget(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
