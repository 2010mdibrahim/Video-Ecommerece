import 'package:e_commerce/core/core/extensions/extensions.dart';
import 'package:e_commerce/core/utils/appStyle.dart';
import 'package:e_commerce/core/utils/app_sizes.dart';
import 'package:e_commerce/features/view/homepage/data/model/add_to_cart_model.dart';
import 'package:e_commerce/features/view/homepage/presentation/controller/home_controller.dart';
import 'package:e_commerce/features/widget/cached_image_network/custom_cached_image_network.dart';
import 'package:e_commerce/features/widget/custom_elevatedButton/custom_eleveted_button.dart';
import 'package:e_commerce/features/widget/custom_toast/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../widget/custom_appbar/custom_appbar.dart';
import '../../../reels/presentation/controller/reels_controller.dart';

class AddToCartListPage extends StatelessWidget {
  AddToCartListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeController(),
        builder: (homeController) {
          return Scaffold(
              backgroundColor: AppColors.slightWhite,
              appBar: CustomAppBar(
                title: "Your Cart",
                appBarBackgroundColor: AppColors.slightWhite,
                titleColor: AppColors.black,
                backiconColor: AppColors.black,
                onBackPressed: () {
                  Navigator.pop(context);
                  homeController.homeAddToCartModel.value
                      .isClickedIncrementDecrementButton = false;
                },
              ),
              body: Obx(() => Column(
                    children: [
                      Expanded(
                        child: homeController.isLoading.value == true
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : homeController
                                        .homeAddToCartModel.value.products ==
                                    null
                                ? Center(
                                    child: CustomSimpleText(
                                      text: 'No Item Available',
                                      color: Colors.black,
                                      alignment: Alignment.center,
                                      fontSize: AppSizes.size20,
                                    ),
                                  )
                                : ListView(
                                    children:
                                        homeController.homeAddToCartModel.value
                                                .products?.entries
                                                .map((entry) {
                                              // Get the key and product item
                                              String key = entry.key;
                                              var product = entry.value;

                                              return Stack(
                                                children: [
                                                  Card(
                                                      child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        Center(
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            child: CustomCachedImageNetwork(
                                                                imageUrl:
                                                                    "http://erp.mahfuza-overseas.com/trending-house/assets/images/products/${product.item?.photo}",
                                                                height: AppSizes
                                                                    .newSize(
                                                                        13),
                                                                weight: AppSizes
                                                                    .newSize(
                                                                        11)),
                                                          ),
                                                        ),
                                                        10.pw,
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CustomSimpleText(
                                                                text: product
                                                                        ?.item
                                                                        ?.name ??
                                                                    '',
                                                                maxLines: 2,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              5.ph,
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  CustomSimpleText(
                                                                    text: product?.price ==
                                                                            null
                                                                        ? "0"
                                                                        : "৳${int.parse(product?.price.toString() ?? '')}",
                                                                    maxLines: 2,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        AppSizes
                                                                            .size13,
                                                                  ),
                                                                  CustomSimpleText(
                                                                    text:
                                                                        "Available: ${product?.stock}",
                                                                    maxLines: 2,
                                                                    fontSize:
                                                                        AppSizes
                                                                            .size13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
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
                                                                    text:
                                                                        "Quantity",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        AppSizes
                                                                            .size14,
                                                                    color: AppColors
                                                                        .black,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      InkWell(
                                                                          onTap:
                                                                              () {
                                                                            if ((product?.qty ?? 0) >
                                                                                1) {
                                                                              homeController.addByOneFunction(
                                                                                id: product.videoId,
                                                                                itemId: product.item?.id,
                                                                                singleItemPrice: product.item?.price,
                                                                                item: product,
                                                                                type: "decrement",
                                                                              );
                                                                            }
                                                                          },
                                                                          child:
                                                                              CustomContainer(value: "-")),
                                                                      5.pw,
                                                                      if (product
                                                                              ?.productCountIncrement ==
                                                                          null)
                                                                        CustomContainer(
                                                                            value:
                                                                                "${product?.productCountIncrement = product?.qty}")
                                                                      else
                                                                        CustomContainer(
                                                                            value:
                                                                                "${product?.productCountIncrement}"),
                                                                      5.pw,
                                                                      InkWell(
                                                                          onTap:
                                                                              () {
                                                                            // homeController
                                                                            //     .increment(
                                                                            //     item:
                                                                            //     product);
                                                                            homeController.addByOneFunction(
                                                                              id: product.videoId,
                                                                              itemId: product.item?.id,
                                                                              singleItemPrice: product.item?.price,
                                                                              item: product,
                                                                              type: "increment",
                                                                            );
                                                                          },
                                                                          child:
                                                                              CustomContainer(value: "+")),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              5.ph,
                                                              // Initialize priceSum if it's null
                                                              if (product
                                                                      ?.priceSum ==
                                                                  null)
                                                                CustomSimpleText(
                                                                  text:
                                                                      "৳${product?.priceSum = product.price}",
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                )
                                                              else
                                                                CustomSimpleText(
                                                                  text:
                                                                      "৳${product?.priceSum ?? '0'}",
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
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
                                                            homeController.removeToCartFunction(
                                                                product?.item
                                                                        ?.id
                                                                        .toString() ??
                                                                    '',
                                                                homeController
                                                                    .homeAddToCartModel
                                                                    .value
                                                                    .products);
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .delete_forever_sharp,
                                                            size: 20,
                                                            color: Colors.red,
                                                          )))
                                                ],
                                              );
                                            }).toList() ??
                                            [],
                                  ),
                      ),
                      InkWell(
                        onTap: () {
                          if (homeController
                                  .homeAddToCartModel.value.products ==
                              null) {
                            errorToast(
                                context: context, msg: "No Item Available");
                          } else {
                            homeController.isContinueClicked.value = false;
                            homeController.shippingSelectedValue.value = 0;
                            homeController.packagingSelectedValue.value = 1;
                            homeController.clearData();
                            homeController.homeAddToCartFunction(
                                from: "dialog");
                          }
                        },
                        child: homeController.isCheckOutLoading.value == true
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Container(
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
                  )));
        });
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
}
