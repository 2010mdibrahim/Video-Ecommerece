import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/di/app_component.dart';
import '../../../../../core/source/dio_client.dart';
import '../../data/model/checkout_model.dart';
import '../../domain/repository/home_repository.dart';
import '../../domain/usecase/home_pass_usecase.dart';

mixin CheckoutController on GetxController{
  var checkoutModel = CheckoutModel().obs;
  var isCheckOutDataLoding = false.obs;
  checkOutFunction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var carts = {"cart": prefs.getString('cart') ?? ''};
      CheckOutPassUseCase homePassUseCase =
      CheckOutPassUseCase(locator<HomeRepository>());
      var response = await homePassUseCase(data: carts);
      if (response?.data != null && response?.data is CheckoutModel) {
        checkoutModel.value = response?.data ?? CheckoutModel();
        print(response?.data);
      } else {
        print('No data found');
      }
    } catch (e) {
      isCheckOutDataLoding.value = false;
      print("This is an error: ${e.toString()}");
    } finally {
      isCheckOutDataLoding.value = false;
    }
  }

}