import 'package:e_commerce/core/di/app_component.dart';
import 'package:e_commerce/features/view/homepage/data/model/checkout_model.dart';
import 'package:e_commerce/features/view/homepage/presentation/controller/checkout_controller.dart';
import 'package:e_commerce/features/view/homepage/presentation/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/appStyle.dart';

class ShippingMethodWidget extends StatelessWidget {
   ShippingMethodWidget({super.key});
var checkoutController = locator<HomeController>();
  @override
  Widget build(BuildContext context) {
    return  Column(
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
              itemCount: checkoutController.checkoutModel.value.shippingData?.length,
              itemBuilder: (_, index) {
                var item =
                checkoutController.checkoutModel.value.shippingData?[index];
                return Obx(() => Row(
                  children: [
                    Radio<int>(
                      value: item?.price.toInt() ?? 0,
                      groupValue: checkoutController.shippingSelectedValue.value,
                      onChanged: (int? value) {
                        checkoutController.shippingSelectedValue.value = value!;
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
        Obx(()=> Visibility(
          visible: checkoutController.shippingSelectedValue.value != 0 ? true : false,
          child: Column(
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
                itemCount: checkoutController.checkoutModel.value.packageData?.length,
                itemBuilder: (_, index) {
                  var item =
                  checkoutController.checkoutModel.value.packageData?[index];
                  return Obx(() => Row(
                    children: [
                      Radio<int>(
                        value: item?.price.toInt() ?? 0,
                        groupValue: checkoutController.packagingSelectedValue.value,
                        onChanged: (int? value) {
                          checkoutController.packagingSelectedValue.value = value!;
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
        ),)
      ],
    );
  }
}
