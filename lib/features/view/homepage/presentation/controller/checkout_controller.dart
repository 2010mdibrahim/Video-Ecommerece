import 'package:dio/dio.dart';
import 'package:e_commerce/core/core/extensions/extensions.dart';
import 'package:e_commerce/features/view/authentication/sign_in/data/model/login_model.dart';
import 'package:e_commerce/features/view/homepage/presentation/widget/billing_information_widget.dart';
import 'package:e_commerce/features/widget/custom_toast/custom_toast.dart';
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
import '../../data/model/cashon_delivery_model.dart';
import '../../data/model/checkout_model.dart';
import '../../data/model/coupon_code_model.dart';
import '../../domain/repository/home_repository.dart';
import '../../domain/usecase/home_pass_usecase.dart';
import '../widget/information_widget.dart';
import '../widget/shipping_method_widget.dart';

mixin CheckoutController on GetxController {
  var checkoutModel = CheckoutModel().obs;
  var couponCodeModel = CouponCodeModel().obs;
  var cashOnDeliveryModel = CashonDeliveryModel().obs;
  var loginModel = LoginModel().obs;
  var isCheckOutDataLoding = false.obs;
  var isCashOnDeliveryLoading = false.obs;
  var isCouponClicked = false.obs;
  var homeAddToCartModel = HomeAddToCartModel().obs;
  var addByOneModel = AddByOneModel().obs;
  var fullNameController = TextEditingController().obs;
  var phoneNumberController = TextEditingController().obs;
  var detailAddressController = TextEditingController().obs;
  var orderNotesController = TextEditingController().obs;
  var couponCodeController = TextEditingController().obs;
  var shippingSelectedValue = 0.obs;
  var shippingSelectedValueId = 0.obs;
  var packagingSelectedValue = 1.obs;
  var packagingSelectedValueId = 1.obs;
  var isContinueClicked = false.obs;
  var shippingDifferentAddress = false.obs;
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

  couponCodeFunction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("value of coupon");
    try {
      if (couponCodeController.value.text.isNotEmpty) {
        isCheckOutDataLoding.value = true;
        var carts = {
          "code": couponCodeController.value.text,
          "total":
              "${(checkoutModel.value.totalPrice?.toInt() ?? 0) + (shippingSelectedValue.value.toInt()) + (packagingSelectedValue.value.toInt())}",
          "shipping_cost": "0",
          "exist_code": session.getExistingCode ?? '',
          "cart": prefs.getString('cart') ?? ''
        };
        CouponCodePassUseCase codePassUseCase =
            CouponCodePassUseCase(locator<HomeRepository>());
        var response = await codePassUseCase(data: carts);
        if (response?.data != null && response?.data is CouponCodeModel) {
          couponCodeModel.value = response?.data ?? CouponCodeModel();
          session.setExistingCode = couponCodeModel.value.existCode;
          print(response?.data);
        } else {
          ErrorDialog(navigatorKey.currentContext!, msg: "No Coupon Available");
        }
      }
    } catch (e) {
      isCheckOutDataLoding.value = false;
      print("This is an error: ${e.toString()}");
    } finally {
      isCheckOutDataLoding.value = false;
    }
  }

  cashOnDeliveryFunction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("value of coupon");
    try {
      isCashOnDeliveryLoading.value = true;
      print("name ${session.getPhoneNumber}");
      var carts = {
        "shipping": "shipto",
        "name": session.getFullName ?? '',
        "phone": session.getPhoneNumber ?? '',
        "address": session.getAddress ?? '',
        "customer_country": "Bangladesh",
        "shipping_country": "Bangladesh",
        "shipping_name": fullNameController.value.text ?? '',
        "shipping_phone": phoneNumberController.value.text ?? '',
        "shipping_address": detailAddressController.value.text ?? '',
        "order_notes": orderNotesController.value.text ?? '',
        "method": "Cash On Delivery",
        "shipping_cost": shippingSelectedValue.value.toString() ?? '',
        "packing_cost": packagingSelectedValue.value.toString() ?? '',
        "dp": checkoutModel.value.digital.toString() ?? '',
        "tax": homeAddToCartModel.value.tx.toString() ?? '',
        "totalQty": checkoutModel.value.totalQty.toString() ?? '',
        "vendor_shipping_id": shippingSelectedValueId.value.toString() ?? '',
        "vendor_packing_id": packagingSelectedValueId.value.toString() ?? '',
        "total": couponCodeModel.value.totalPrice ??
            checkoutModel.value.totalPrice.toString() ??
            '',
        "coupon_code": couponCodeController.value.text ?? '',
        "coupon_id": couponCodeModel.value.couponId.toString() ?? '',
        "user_id": loginModel.value.data?.id.toString() ?? '',
        "cart": prefs.getString('cart') ?? ''
      };
      CashOnDeliveryPassUseCase cashOnDeliveryPassUseCase =
          CashOnDeliveryPassUseCase(locator<HomeRepository>());
      var response = await cashOnDeliveryPassUseCase(data: carts);
      if (response?.data != null && response?.data is CashonDeliveryModel) {
        cashOnDeliveryModel.value = response?.data ?? CashonDeliveryModel();
        prefs.remove('addToCart');
        prefs.remove('cart');
        couponCodeModel.value = CouponCodeModel();
        addByOneModel.value = AddByOneModel();
        homeAddToCartModel.value = HomeAddToCartModel();
        checkoutModel.value = CheckoutModel();
      }
    } catch (e) {
      isCashOnDeliveryLoading.value = false;
      print("This is an error: ${e.toString()}");
    } finally {
      isCashOnDeliveryLoading.value = false;
    }
  }

  Future<void> confirmationDialog(
    BuildContext context,
    HomeAddToCartModel addToCartModel,
  ) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Obx(() => AlertDialog(
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
                  isCheckOutDataLoding.value == true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : CustomElevatedButton(
                          text: "Place Order",
                          onPress: () {
                            Navigator.pop(context);
                            isCouponClicked.value = false;
                            Future.delayed(Duration(seconds: 3), () {});
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
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // Ensure this happens after the first frame is built
    //   shippingSelectedValue.value =
    //       checkoutModel.value.shippingData?.first.price ?? 0;
    // });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          backgroundColor: Colors.white,
          title: (fullNameController.value.text.isNotEmpty ||
                  phoneNumberController.value.text.isNotEmpty ||
                  detailAddressController.value.text.isNotEmpty)
              ? CustomSimpleText(
                  text: "Billing Details",
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.size18,
                  color: AppColors.black,
                )
              : const SizedBox.shrink(),
          content: Obx(
            () => SizedBox(
              // Constrain the width
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    isContinueClicked.value == true
                        ? InformationWidget()
                        : BillingInformationWidget(
                            checkoutModel: addToCartModel),
                    10.ph,
                    ShippingMethodWidget(),
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
                              text: couponCodeModel.value.totalPrice == null
                                  ? "${(addToCartModel.totalPrice?.toInt() ?? 0) + (shippingSelectedValue.value.toInt()) + (packagingSelectedValue.value.toInt())}"
                                  : couponCodeModel.value.totalPrice.toString(),
                              fontWeight: FontWeight.bold,
                              fontSize: AppSizes.size13,
                              color: AppColors.black,
                            )),
                      ],
                    ),
                    10.ph,
                    Obx(() => Visibility(
                          visible:
                              packagingSelectedValue.value != 1 ? true : false,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Visibility(
                                visible: isContinueClicked.value == true
                                    ? true
                                    : false,
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: CustomElevatedButton(
                                      text: "Back",
                                      topLeft: 10,
                                      bottomRight: 10,
                                      onPress: () {
                                        isContinueClicked.value = false;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: CustomElevatedButton(
                                    text: "Continue",
                                    topLeft: 10,
                                    bottomRight: 10,
                                    onPress: () {
                                      if (fullNameController
                                              .value.text.isEmpty &&
                                          shippingDifferentAddress.value ==
                                              true) {
                                        // errorToast(context: context, msg: "Please Enter your name");
                                        ErrorDialog(context,
                                            msg: "Please Enter your name");
                                      } else if (phoneNumberController
                                              .value.text.isEmpty &&
                                          shippingDifferentAddress.value ==
                                              true) {
                                        ErrorDialog(context,
                                            msg:
                                                "Please Enter your phone number");
                                      } else if (detailAddressController
                                              .value.text.isEmpty &&
                                          shippingDifferentAddress.value ==
                                              true) {
                                        ErrorDialog(context,
                                            msg: "Please Enter address");
                                      } else {
                                        isContinueClicked.value = true;
                                        cashOnDeliveryFunction();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
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

  void ErrorDialog(BuildContext context, {required String msg}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Less curved corners
          ),
          title: CustomSimpleText(
            text: "Missing Information",
            color: Colors.red,
            fontSize: AppSizes.size17,
          ),
          content: SingleChildScrollView(
            // Allows the content to scroll if it exceeds available height
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Ensures dialog adjusts to content height
              children: [
                CustomSimpleText(
                  text: msg,
                  color: Colors.black,
                  fontSize: AppSizes.size16,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: CustomSimpleText(
                alignment: Alignment.centerRight,
                text: "Close",
                color: Colors.red,
                fontSize: AppSizes.size16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }

  void clearData() {
    detailAddressController.value.clear();
    phoneNumberController.value.clear();
    fullNameController.value.clear();
  }
}
