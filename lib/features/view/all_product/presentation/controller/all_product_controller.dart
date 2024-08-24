import 'package:e_commerce/features/view/all_product/data/model/product_category_model.dart';
import 'package:e_commerce/features/view/all_product/domain/repository/product_category_repository.dart';
import 'package:e_commerce/features/view/all_product/domain/usecase/product_category_pass_usecase.dart';
import 'package:e_commerce/features/view/all_product/domain/usecase/product_category_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../core/di/app_component.dart';
import '../../data/model/product_category_wise_product_model.dart';

class AllProductController extends GetxController{
  var isSelected = 0.obs;
  var isLoading = false.obs;
  var isAllProductLoading = false.obs;
  var productCategoryList = <ProductCategoryModel>[].obs;
  var productCategoryWiseProductModel = ProductCategoryWiseProductModel().obs;
  @override
  void onInit() {
    productCategory();
    productCategoryWiseProduct();
    super.onInit();
  }
  productCategory() async {
    try {
      isLoading.value = true;
      ProductCategoryPassUseCase productCategoryUseCase =
      ProductCategoryPassUseCase(locator<ProductCategoryRepository>());
      var response = await productCategoryUseCase();

      if (response?.data != null && response?.data is List<ProductCategoryModel>) {
        print("This is product category");
        List<ProductCategoryModel> dataList = response?.data as List<ProductCategoryModel>;
        productCategoryList.clear();
        productCategoryList.addAll(dataList);
        print("productCategoryList.first.name ${productCategoryList.first.name}");
      } else {
        print('No data found');
      }
    } catch (e) {
      print("This is an error: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
  productCategoryWiseProduct() async {
    try {
      isAllProductLoading.value = true;
      ProductCategoryWiseProductPassUseCase productCategoryUseCase =
      ProductCategoryWiseProductPassUseCase(locator<ProductCategoryRepository>());
      var response = await productCategoryUseCase();
      print("All products ${response?.data.runtimeType}");
      if (response?.data != null && response?.data is ProductCategoryWiseProductModel) {
        print("This is product category");
        productCategoryWiseProductModel.value = response?.data ?? ProductCategoryWiseProductModel();
        print("productCategoryList.first.name ${productCategoryList.first.name}");
      } else {
        print('No data found');
      }
    } catch (e) {
      print("This is an error: ${e.toString()}");
    } finally {
      isAllProductLoading.value = false;
    }
  }

  productDetails({required Map<String, Object> data}) async {
    try {
      isAllProductLoading.value = true;
      productDetailsPassUseCase productCategoryUseCase =
      productDetailsPassUseCase(locator<ProductCategoryRepository>());
      var response = await productCategoryUseCase(data: data);
      print("All products ${response?.data.runtimeType}");
      if (response?.data != null && response?.data is ProductCategoryWiseProductModel) {
        print("This is product full list");
        productCategoryWiseProductModel.value = response?.data ?? ProductCategoryWiseProductModel();
        print("productCategoryList.first.name ${productCategoryList.first.name}");
      } else {
        print('No data found');
      }
    } catch (e) {
      print("This is an error: ${e.toString()}");
    } finally {
      isAllProductLoading.value = false;
    }
  }


}