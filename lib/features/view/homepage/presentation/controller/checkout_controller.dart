import 'package:dio/dio.dart';
import 'package:e_commerce/core/core/extensions/extensions.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/di/app_component.dart';
import '../../../../../core/source/dio_client.dart';
import '../../../../../core/utils/appStyle.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_sizes.dart';
import '../../../../widget/custom_elevatedButton/custom_eleveted_button.dart';
import '../../../../widget/custom_textfield/custom_textfield.dart';
import '../../data/model/add_by_one_model.dart';
import '../../data/model/add_to_cart_model.dart';
import '../../data/model/checkout_model.dart';
import '../../domain/repository/home_repository.dart';
import '../../domain/usecase/home_pass_usecase.dart';

mixin CheckoutController on GetxController{
  var checkoutModel = CheckoutModel().obs;
  var isCheckOutDataLoding = false.obs;
  var isCouponClicked = false.obs;
  var homeAddToCartModel = HomeAddToCartModel().obs;
  var addByOneModel = AddByOneModel().obs;
  var fullNameController = TextEditingController().obs;
  var phoneNumberController = TextEditingController().obs;
  var detailAddressController = TextEditingController().obs;
  var couponCodeController = TextEditingController().obs;
  var shippingSelectedValue = 0.obs;
  var packagingSelectedValue = 0.obs;
  checkOutFunction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      isCheckOutDataLoding.value = true;
      var carts = {"cart": prefs.getString('cart') ?? ''};
      CheckOutPassUseCase homePassUseCase =
      CheckOutPassUseCase(locator<HomeRepository>());
      var response = await homePassUseCase(data: carts);
      if (response?.data != null && response?.data is CheckoutModel) {
        checkoutModel.value = response?.data ?? CheckoutModel();
        billingDetails(navigatorKey.currentContext!, checkoutModel.value);
        print(response?.data);
      } else {
        print('No data fo-und');
      }
    } catch (e) {
      isCheckOutDataLoding.value = false;
      print("This is an error: ${e.toString()}");
    } finally {
      isCheckOutDataLoding.value = false;
    }
  }
  Future<void> confirmationDialog(
      BuildContext context,
      HomeAddToCartModel addToCartModel,
      ) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Obx(()=> AlertDialog(
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
                      text: "৳${addToCartModel.totalPrice}",
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
                      text: "৳${addToCartModel.mainTotal}",
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
              isCheckOutDataLoding.value == true ? const Center(child: CircularProgressIndicator(),) :  CustomElevatedButton(
                text: "Place Order",
                onPress: () {
                  Navigator.pop(context);
                  isCouponClicked.value = false;
                  Future.delayed(Duration(seconds: 3), (){

                  });
                  checkOutFunction();
                },
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Less curved corners
          ),
        ));
      },
    );
  }
  Future<void> billingDetails(
      BuildContext context, CheckoutModel addToCartModel) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Ensure this happens after the first frame is built
      shippingSelectedValue.value =
          checkoutModel.value.shippingData?.first.price ?? 0;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          backgroundColor: Colors.white,
          title: CustomSimpleText(
            text: "Billing Details",
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.size18,
            color: AppColors.black,
          ),
          content: Obx(
                () => SizedBox(
              // Constrain the width
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          child: CustomTextfield(
                            controller: fullNameController.value,
                            hintText: "Full Name",
                            lebelText: "Full Name",
                            labelLeftPadding: 14,
                          ),
                        ),
                      ),
                      10.pw,
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          child: CustomTextfield(
                            controller: phoneNumberController.value,
                            hintText: "Phone Number",
                            lebelText: "Phone Number",
                            labelLeftPadding: 14,
                            textInputType: TextInputType.number,
                          ),
                        ),
                      ),
                    ],
                  ),
                  15.ph,
                  SizedBox(
                    height: 45,
                    child: CustomTextfield(
                      controller: detailAddressController.value,
                      hintText: "Details Address",
                      lebelText: "Details Address",
                      labelLeftPadding: 14,
                    ),
                  ),
                  10.ph,
                  CustomSimpleText(
                    text: "Price Details",
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.size17,
                    color: AppColors.black,
                  ),
                  10.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomSimpleText(
                        text: "Total MRP",
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.size13,
                        color: AppColors.black,
                      ),
                      CustomSimpleText(
                        text: addToCartModel.totalPrice.toString(),
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.size13,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomSimpleText(
                        text: "Total",
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.size13,
                        color: AppColors.black,
                      ),
                      CustomSimpleText(
                        text: addToCartModel.totalPrice.toString(),
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.size13,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                  10.ph,
                  InkWell(
                    onTap: () {
                      isCouponClicked.value = !isCouponClicked.value;
                    },
                    child: const CustomSimpleText(
                      text: "HAVE A PROMOTION CODE?",
                      textDecoration: TextDecoration.underline,
                      alignment: Alignment.center,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  10.ph,
                  Visibility(
                    visible: isCouponClicked.value == false ? false : true,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: CustomTextfield(
                            hintText: "Enter coupon code",
                            lebelText: "Coupon code",
                            controller: couponCodeController.value,
                          ),
                        ),
                        10.pw,
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: CustomElevatedButton(
                              text: "Apply",
                              textSize: 13.0,
                              topLeft: 10,
                              bottomRight: 10,
                              onPress: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  10.ph,
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomSimpleText(
                            text: "SHIPPING METHOD",
                            textDecoration: TextDecoration.none,
                            alignment: Alignment.centerLeft,
                            textAlign: TextAlign.start,
                          ),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: checkoutModel.value.shippingData?.length,
                            itemBuilder: (_, index) {
                              var item =
                              checkoutModel.value.shippingData?[index];
                              return Obx(() => Row(
                                children: [
                                  Radio<int>(
                                    value: item?.price.toInt() ?? 0,
                                    groupValue: shippingSelectedValue.value,
                                    onChanged: (int? value) {
                                      shippingSelectedValue.value = value!;
                                    },
                                  ),
                                  CustomSimpleText(
                                    text:
                                    "${item?.title} + ৳${item?.price}",
                                    textDecoration: TextDecoration.none,
                                    alignment: Alignment.center,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ));
                            },
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomSimpleText(
                            textDecoration: TextDecoration.none,
                            text: "PACKAGING",
                            alignment: Alignment.centerLeft,
                            textAlign: TextAlign.start,
                          ),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: checkoutModel.value.packageData?.length,
                            itemBuilder: (_, index) {
                              var item =
                              checkoutModel.value.packageData?[index];
                              return Obx(() => Row(
                                children: [
                                  Radio<int>(
                                    value: item?.price.toInt() ?? 0,
                                    groupValue: packagingSelectedValue.value,
                                    onChanged: (int? value) {
                                      packagingSelectedValue.value = value!;
                                    },
                                  ),
                                  CustomSimpleText(
                                    text:
                                    "${item?.title} + ৳${item?.price}",
                                    textDecoration: TextDecoration.none,
                                    alignment: Alignment.center,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomSimpleText(
                        text: "Final Price",
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.size13,
                        color: AppColors.black,
                      ),
                      Obx(() => CustomSimpleText(
                        text:
                        "${(addToCartModel.totalPrice?.toInt() ?? 0) + (shippingSelectedValue.value.toInt()) + (packagingSelectedValue.value.toInt())}",
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.size13,
                        color: AppColors.black,
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Less curved corners
          ),
        );
      },
    );
  }

}