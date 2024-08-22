import 'package:e_commerce/features/view/all_product/data/model/product_category_model.dart';
import 'package:e_commerce/features/view/all_product/domain/repository/product_category_repository.dart';
import 'package:e_commerce/features/view/all_product/domain/usecase/product_category_pass_usecase.dart';
import 'package:e_commerce/features/view/all_product/domain/usecase/product_category_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../core/di/app_component.dart';

class AllProductController extends GetxController{
  var isSelected = 0.obs;
  var isLoading = false.obs;
  var productCategoryList = <ProductCategoryModel>[].obs;
  @override
  void onInit() {
    productCategory();
    super.onInit();
  }
  productCategory() async {
    try {
      isLoading.value = true;
      ProductCategoryPassUseCase productCategoryUseCase =
      ProductCategoryPassUseCase(locator<ProductCategoryRepository>());
      var response = await productCategoryUseCase();

      // Check if the response contains data
      if (response?.data != null && response?.data is List<ProductCategoryModel>) {
        print("This is product category");
        List<ProductCategoryModel> dataList = response?.data as List<ProductCategoryModel>;
        productCategoryList.clear();
        // Add each item directly to the observable list
        productCategoryList.addAll(dataList);
        print("productCategoryList.first.name ${productCategoryList.first.name}");
      } else {
        // Handle the case where response or data is null
        print('No data found');
      }
    } catch (e) {
      print("This is an error: ${e.toString()}");
      // Optionally, show error toast or handle error
    } finally {
      isLoading.value = false;
    }
  }


}