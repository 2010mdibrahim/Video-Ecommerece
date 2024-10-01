import 'package:e_commerce/core/core/extensions/extensions.dart';
import 'package:e_commerce/features/view/homepage/data/model/checkout_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/di/app_component.dart';
import '../../../../../core/utils/appStyle.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_sizes.dart';
import '../../../../widget/custom_elevatedButton/custom_eleveted_button.dart';
import '../../../../widget/custom_textfield/custom_textfield.dart';
import '../controller/home_controller.dart';

class BillingInformationWidget extends StatelessWidget {
  final CheckoutModel checkoutModel;
   BillingInformationWidget({super.key, required this.checkoutModel});
  var checkoutController = locator<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 45,
                child: CustomTextfield(
                  controller: checkoutController.fullNameController.value,
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
                  controller: checkoutController.phoneNumberController.value,
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
            controller: checkoutController.detailAddressController.value,
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
              text: checkoutModel.totalPrice.toString(),
              fontWeight: FontWeight.bold,
              fontSize: AppSizes.size13,
              color: AppColors.black,
            ),
          ],
        ),
        checkoutController.couponCodeModel.value.totalPrice != null? SizedBox(height: 10,) : SizedBox.shrink(),
        Visibility(
          visible:checkoutController.couponCodeModel.value.totalPrice != null ? true : false ,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomSimpleText(
                  text: "Discount (${checkoutController.couponCodeModel.value.couponPercentage})",
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
                  text: "৳${checkoutController.couponCodeModel.value.couponDiscount}",
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
        ),
        10.ph,
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
              text: checkoutController.couponCodeModel.value.totalPrice == null ? checkoutModel.totalPrice.toString() : checkoutController.couponCodeModel.value.totalPrice.toString(),
              fontWeight: FontWeight.bold,
              fontSize: AppSizes.size13,
              color: AppColors.black,
            ),
          ],
        ),
        10.ph,
        InkWell(
          onTap: () {
            checkoutController.isCouponClicked.value = !checkoutController.isCouponClicked.value;
          },
          child: const CustomSimpleText(
            text: "HAVE A PROMOTION CODE?",
            textDecoration: TextDecoration.underline,
            alignment: Alignment.center,
            textAlign: TextAlign.center,
          ),
        ),
        10.ph,
        Obx(()=> Visibility(
          visible: checkoutController.isCouponClicked.value == false ? false : true,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: CustomTextfield(
                  hintText: "Enter coupon code",
                  lebelText: "Coupon code",
                  controller: checkoutController.couponCodeController.value,
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
                      checkoutController.couponCodeFunction();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),),
      ],
    );
  }
}
