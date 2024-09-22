import 'package:e_commerce/features/view/all_product/data/model/product_category_model.dart';
import 'package:e_commerce/features/view/all_product/domain/repository/product_category_repository.dart';
import 'package:e_commerce/features/view/all_product/domain/usecase/product_category_pass_usecase.dart';
import 'package:e_commerce/features/view/all_product/domain/usecase/product_category_usecase.dart';
import 'package:e_commerce/features/view/all_product/presentation/controller/video_upload_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../core/di/app_component.dart';
import '../../../../../core/model/dropdown_model.dart';
import '../../../../../core/routes/route_name.dart';
import '../../../../../core/routes/router.dart';
import '../../../../../main.dart';
import '../../data/model/product_category_wise_item_details.dart';
import '../../data/model/product_category_wise_product_model.dart';

class AllProductController extends GetxController with VideoUploadController{
  var isSelected = 0.obs;
  var isLoading = false.obs;
  var isAllProductLoading = false.obs;
  var isProductDetailsLoading = false.obs;
  var productCategoryList = <ProductCategoryModel>[].obs;
  var productCategoryProductList = <ProductCategoryModel>[].obs;
  var productCategoryWiseProductModel = ProductCategoryWiseProductModel().obs;
  var productCategoryWiseProductModell = ProductCategoryWiseProductModel().obs;
  var productCategoryWiseProductDetailsModel = ProductCategoryWiseItemDetails().obs;
  var image = "".obs;
  DropdownModel? selectedDropdown;
  List<DropdownModel> popupItemMenu = [];
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
      popupItemMenu.clear();
      popupItemMenu.add(DropdownModel(0, "Select category"));
      if (response?.data != null && response?.data is List<ProductCategoryModel>) {
        print("This is product category");
        List<ProductCategoryModel> dataList = response?.data as List<ProductCategoryModel>;
        productCategoryList.clear();
        productCategoryList.addAll(dataList);
        for (var category in productCategoryList) {
          for (var subCategory in category.subs ?? []) {
            popupItemMenu.add(DropdownModel(subCategory.id, subCategory.name));
          }
        }
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
  selectMenu(DropdownModel selectedValue){
    selectedDropdown = selectedValue;
    print("the item ${selectedDropdown?.name}");
    update();
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
  productCategoryDetails({required String itemName}) async {
    try {
      isProductDetailsLoading.value = true;
      ProductCategoryWiseItemDetailsPassUseCase productCategoryUseCase =
      ProductCategoryWiseItemDetailsPassUseCase(locator<ProductCategoryRepository>());
      var response = await productCategoryUseCase(itemName: itemName);
      print("All products ${response?.data.runtimeType}");
      if (response?.data != null && response?.data is ProductCategoryWiseItemDetails) {
        print("This is product category");
        productCategoryWiseProductDetailsModel.value = response?.data ?? ProductCategoryWiseItemDetails();
        image.value = productCategoryWiseProductDetailsModel.value.itemDetail?.thumbnail;
        RouteGenerator.pushNamed(
            navigatorKey.currentContext!, Routes.productCategoryItemDetailsWise);
        print("productCategoryList.first.name ${productCategoryList.first.name}");
      } else {
        print('No data found');
      }
    } catch (e) {
      print("This is an error: ${e.toString()}");
    } finally {
      isProductDetailsLoading.value = false;
    }
  }

  categoryWiseProductItems({required Map<String, Object> data}) async {
    try {
      isAllProductLoading.value = true;
      ProductCategoryWiseItemPassUseCase productCategoryUseCase =
      ProductCategoryWiseItemPassUseCase(locator<ProductCategoryRepository>());
      var response = await productCategoryUseCase(data: data);
      print("All products ${response?.data.runtimeType}");
      if (response?.data != null && response?.data is ProductCategoryWiseProductModel) {
        print("This is product full list");
        productCategoryWiseProductModell.value = response?.data ?? ProductCategoryWiseProductModel();
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