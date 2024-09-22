import 'package:e_commerce/core/core/extensions/extensions.dart';
import 'package:e_commerce/core/utils/appStyle.dart';
import 'package:e_commerce/core/utils/app_sizes.dart';
import 'package:e_commerce/features/widget/cached_image_network/custom_cached_image_network.dart';
import 'package:e_commerce/features/widget/custom_elevatedButton/custom_eleveted_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/di/app_component.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../widget/custom_appbar/custom_appbar.dart';
import '../../../reels/presentation/controller/reels_controller.dart';

class AddToCartListPage extends StatelessWidget {
  AddToCartListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slightWhite,
      appBar: CustomAppBar(
        title: "Your Cart",
        appBarBackgroundColor: AppColors.slightWhite,
        titleColor: AppColors.black,
        backiconColor: AppColors.black,
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: GetBuilder(
          init: ReelsController(),
          builder: (reelController) {
            return Obx(() => Column(
                  children: [
                    Expanded(
                      child: reelController.addToCartListModel.value?.isEmpty ??
                              false
                          ? Center(
                              child: CustomSimpleText(
                                text: 'No Item Available',
                                color: Colors.black,
                                alignment: Alignment.center,
                                fontSize: AppSizes.size20,
                              ),
                            )
                          : ListView.builder(
                              itemCount: reelController
                                  .addToCartListModel.value?.length,
                              itemBuilder: (_, index) {
                                var item = reelController
                                    .addToCartListModel.value?[index];
                                return Stack(
                                  children: [
                                    Card(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Center(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: CustomCachedImageNetwork(
                                                  imageUrl:
                                                      "http://erp.mahfuza-overseas.com/trending-house/assets/images/products/${item?.item?.photo}",
                                                  height: AppSizes.newSize(13),
                                                  weight: AppSizes.newSize(11)),
                                            ),
                                          ),
                                          10.pw,
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomSimpleText(
                                                  text: item?.item?.name ?? '',
                                                  maxLines: 2,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                5.ph,
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CustomSimpleText(
                                                      text: item?.price == null
                                                          ? "0"
                                                          : "৳${int.parse(item?.price.toString() ?? '')}",
                                                      maxLines: 2,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: AppSizes.size13,
                                                    ),
                                                    CustomSimpleText(
                                                      text:
                                                          "Available: ${item?.stock}",
                                                      maxLines: 2,
                                                      fontSize: AppSizes.size13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ],
                                                ),
                                                5.ph,
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CustomSimpleText(
                                                      text: "Quantity",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: AppSizes.size14,
                                                      color: AppColors.black,
                                                    ),
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                            onTap: () {
                                                              if ((item?.qty ??
                                                                      0) >
                                                                  1) {
                                                                reelController
                                                                    .decrement(
                                                                        item:
                                                                            item);
                                                              }
                                                            },
                                                            child:
                                                                CustomContainer(
                                                                    value:
                                                                        "-")),
                                                        5.pw,
                                                        if (item?.productCountIncrement ==
                                                            null)
                                                          CustomContainer(
                                                              value:
                                                                  "${item?.productCountIncrement = item?.qty}")
                                                        else
                                                          CustomContainer(
                                                              value:
                                                                  "${item?.productCountIncrement}"),
                                                        5.pw,
                                                        InkWell(
                                                            onTap: () {
                                                              reelController
                                                                  .increment(
                                                                      item:
                                                                          item);
                                                            },
                                                            child:
                                                                CustomContainer(
                                                                    value:
                                                                        "+")),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                5.ph,
                                                // Initialize priceSum if it's null
                                                if (item?.priceSum == null)
                                                  CustomSimpleText(
                                                    text:
                                                        "৳${item?.priceSum = item.price}",
                                                    alignment:
                                                        Alignment.centerRight,
                                                  )
                                                else
                                                  CustomSimpleText(
                                                    text:
                                                        "৳${item?.priceSum ?? '0'}",
                                                    alignment:
                                                        Alignment.centerRight,
                                                  )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                                    Positioned(
                                        right: 0,
                                        child: IconButton(
                                            onPressed: () async {
                                              reelController
                                                  .removeToCartFunction(
                                                      item?.item?.id
                                                              .toString() ??
                                                          '',
                                                      item);
                                            },
                                            icon: Icon(
                                              Icons.delete_forever_sharp,
                                              size: 20,
                                              color: Colors.red,
                                            )))
                                  ],
                                );
                              }),
                    ),
                    InkWell(
                      onTap: () {
                        var sum = 0;
                        reelController.addToCartListModel.value
                            ?.forEach((value) {
                          sum =
                              sum + int.parse(value?.priceSum.toString() ?? '');
                        });
                        print("price sum $sum");
                        confirmationDialog(context, sum);
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(75),
                                topRight: Radius.circular(75)),
                            color: AppColors.backgroundColor),
                        child: CustomSimpleText(
                          text: "CHECKOUT",
                          fontSize: AppSizes.size18,
                          fontWeight: FontWeight.bold,
                          alignment: Alignment.center,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    5.ph,
                  ],
                ));
          }),
    );
  }

  Widget CustomContainer({required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.deepGrey),
          color: Colors.transparent),
      child: Center(
        child: CustomSimpleText(
          text: value,
          fontWeight: FontWeight.bold,
          fontSize: AppSizes.size12,
          color: AppColors.black,
          alignment: Alignment.bottomCenter,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Future<void> confirmationDialog(
    BuildContext context,
    int sum,
  ) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: CustomSimpleText(
            text: "PRICE DETAILS",
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.size18,
            color: AppColors.black,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomSimpleText(
                      text: "Total MRP",
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizes.size14,
                      color: AppColors.black,
                      textDecoration: TextDecoration.none,
                      alignment: Alignment.centerLeft,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: CustomSimpleText(
                      text: "৳$sum",
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizes.size14,
                      color: AppColors.black,
                      textDecoration: TextDecoration.none,
                      alignment: Alignment.centerRight,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              10.ph,
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomSimpleText(
                      text: "Discount",
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizes.size14,
                      color: AppColors.black,
                      textDecoration: TextDecoration.none,
                      alignment: Alignment.centerLeft,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: CustomSimpleText(
                      text: "৳0",
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizes.size14,
                      color: AppColors.black,
                      textDecoration: TextDecoration.none,
                      alignment: Alignment.centerRight,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              10.ph,
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomSimpleText(
                      text: "Tax",
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizes.size14,
                      color: AppColors.black,
                      textDecoration: TextDecoration.none,
                      alignment: Alignment.centerLeft,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: CustomSimpleText(
                      text: "৳0",
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizes.size14,
                      color: AppColors.black,
                      textDecoration: TextDecoration.none,
                      alignment: Alignment.centerRight,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              5.ph,
              Divider(),
              5.ph,
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomSimpleText(
                      text: "Total",
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizes.size14,
                      color: AppColors.black,
                      textDecoration: TextDecoration.none,
                      alignment: Alignment.centerLeft,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: CustomSimpleText(
                      text: "৳$sum",
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizes.size14,
                      color: AppColors.black,
                      textDecoration: TextDecoration.none,
                      alignment: Alignment.centerRight,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              10.ph,
              CustomSimpleText(
                text: "HAVE A PROMOTION CODE?",
                fontWeight: FontWeight.bold,
                fontSize: AppSizes.size14,
                color: AppColors.black,
                textDecoration: TextDecoration.underline,
                alignment: Alignment.center,
                textAlign: TextAlign.center,
              ),
              10.ph,
              CustomElevatedButton(
                text: "Place Order",
                onPress: () {},
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
