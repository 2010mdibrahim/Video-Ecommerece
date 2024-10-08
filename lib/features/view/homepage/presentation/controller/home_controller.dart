import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_commerce/core/core/extensions/extensions.dart';
import 'package:e_commerce/features/view/homepage/data/model/add_to_cart_model.dart';
import 'package:e_commerce/features/view/homepage/presentation/controller/checkout_controller.dart';
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
import '../../domain/repository/home_repository.dart';
import '../../domain/usecase/home_pass_usecase.dart';

class HomeController extends GetxController with CheckoutController {
  var isLoading = false.obs;
  var isCheckOutLoading = false.obs;
  var isAddByOneLoading = false.obs;

  @override
  void onInit() {
    // homeAddToCartFunction();
    super.onInit();
  }

  homeAddToCartFunction({String? from}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (from == "dialog") {
        isCheckOutLoading.value = true;
      } else {
        isLoading.value = true;
      }
      var carts = {"cart": prefs.getString('cart') ?? ''};
      HomePassUseCase homePassUseCase =
          HomePassUseCase(locator<HomeRepository>());
      var response = await homePassUseCase(data: carts);
      if (response?.data != null && response?.data is HomeAddToCartModel) {
        homeAddToCartModel.value = response?.data ?? HomeAddToCartModel();
        if (from == "dialog") {
          confirmationDialog(
              navigatorKey.currentContext!, homeAddToCartModel.value);
        }
      } else {
        print('No data found');
      }
    } catch (e) {
      isLoading.value = false;
      isCheckOutLoading.value = false;
      print("This is an error: ${e.toString()}");
    } finally {
      isCheckOutLoading.value = false;
      isLoading.value = false;
    }
  }

  addByOneFunction(
      {String? id,
      int? itemId,
      int? singleItemPrice,
      required ProductItem item,
      required String type}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      isAddByOneLoading.value = true;
      var addByOne = {
        "id": itemId.toString() ?? '',
        "itemid": itemId.toString() ?? '',
        "size_qty": "",
        "type": type,
        "size_price": singleItemPrice.toString() ?? '',
        "cart": prefs.getString('cart') ?? ''
      };
      AddByPassUseCase addByPassUseCase =
          AddByPassUseCase(locator<HomeRepository>());
      var response = await addByPassUseCase(data: addByOne);
      if (response?.data != null && response?.data is AddByOneModel) {
        addByOneModel.value = response?.data ?? AddByOneModel();
        await prefs.setString('cart', response?.data?.cart ?? '');
        if (type == "increment") {
          increment(item: item);
        } else {
          decrement(item: item);
        }
        // successToast(context: navigatorKey.currentContext!, msg: msg)
      } else {
        errorToast(
            context: navigatorKey.currentContext!,
            msg: "Something went wrong. Try again");
      }
    } catch (e) {
      isAddByOneLoading.value = false;
      print("This is an error: ${e.toString()}");
    } finally {
      isAddByOneLoading.value = false;
    }
  }

  void increment({required ProductItem item}) {
    if (item?.priceSum != null && (item?.productCountIncrement ?? 0) >= 1) {
      if ((item?.productCountIncrement ?? 0) > 1) {
        item?.priceSum =
            item.priceSum! + int.parse(item.item?.price.toString() ?? '');
      } else {
        item?.priceSum =
            item.priceSum! + int.parse(item.item?.price.toString() ?? '');
      }
      item?.qty = (item.qty ?? 0) + 1;
      item?.productCountIncrement = item.qty;
      print("count ${item?.productCountIncrement}");
    } else {
      item?.priceSum = int.parse(item.price.toString());
      item?.productCountIncrement = 1;
    }
    update();
  }

  void decrement({required ProductItem item}) {
    // Ensure the item exists and that the quantity is greater than 1
    if (item?.priceSum != null && (item?.productCountIncrement ?? 0) > 1) {
      // Decrease the priceSum by item price
      item?.priceSum = (item?.priceSum ?? 0) - (item?.item?.price ?? 0);

      // Decrease the qty by 1
      item?.qty = (item?.qty ?? 0) - 1;

      // Reflect the new qty in productCountIncrement
      item?.productCountIncrement = item?.qty;

      print("Updated priceSum: ${item?.priceSum}");
      print("Updated qty: ${item?.qty}");
    } else {
      // Handle the case where priceSum is null or the quantity is 1 or less
      item?.priceSum = item?.item?.price ?? 0;
      item?.productCountIncrement = 1;
    }
    update(); // Ensure UI updates
  }

// void removeItem(Data? item){
//   addToCartListModel.value.data?.remove(item);
//   update();
// }
  void removeToCartFunction(
      String id, Map<String, ProductItem>? products) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the current cart list from SharedPreferences
    String? cartListString = prefs.getString('addToCart');

    if (cartListString != null) {
      // Deserialize the JSON string to List
      List<dynamic> cartList = jsonDecode(cartListString);

      // Remove the specific item (if found)
      cartList.removeWhere((item) => item['product_id'] == id);

      // Serialize the updated list back to JSON
      // String updatedCartListString = jsonEncode(cartList);

      // Save the updated list back to SharedPreferences
      // await prefs.setString('addToCart', updatedCartListString);

      // Also update your local model (if needed)

      homeAddToCartModel.value.products?.remove(id);
    }
    update();
  }




}
