
import 'dart:convert';
import 'package:e_commerce/core/network/configuration.dart';
import 'package:e_commerce/features/view/authentication/sign_in/data/model/user_info_model.dart';
import 'package:e_commerce/features/widget/custom_toast/custom_toast.dart';
import 'package:e_commerce/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../../core/di/app_component.dart';
import '../../../../../../core/source/dio_client.dart';
import '../../../../../../core/source/model/api_response.dart';
import '../../../../../../core/source/session_manager.dart';
import '../../../../../../core/utils/constants.dart';
import '../model/product_category_model.dart';
import 'package:dio/dio.dart' as dio;

import '../model/product_category_wise_item_details.dart';
import '../model/product_category_wise_product_model.dart';
var session = locator<SessionManager>();

class ProductCategoryService {
  final DioClient _dioClient = locator<DioClient>();

  Future<Response<List<ProductCategoryModel>>?> productCategoryPass() async {
    Response<List<ProductCategoryModel>>? apiResponse;

    await _dioClient.get(
      path: NetworkConfiguration.productCategory,
      responseCallback: (response, message) {
        // Handle successful response
        print("this is product");

        // Check if the response is a List
        if (response is List) {
          // Convert the list of dynamic to a list of ProductCategoryModel
          List<ProductCategoryModel> productCategories = response
              .map((item) => ProductCategoryModel.fromJson(item as Map<String, dynamic>))
              .toList();
          apiResponse = Response.success(productCategories);
        } else {
          // Handle the case where the response is not a list (optional)
          apiResponse = Response.error("Unexpected response format", null);
        }
      },
      failureCallback: (message, status) {
        print("this is message error $message $status");
        apiResponse = Response.error(message, status);
      },
    );

    logger.e("api response ${apiResponse?.data}");
    return apiResponse;
  }

  Future<Response<ProductCategoryWiseProductModel?>?> productCategoryWiseProductPass() async {
    Response<ProductCategoryWiseProductModel?>? apiResponse;

    await _dioClient.get(
      path: NetworkConfiguration.productCategoryWiseProduct,
      responseCallback: (response, message) {
        var products = ProductCategoryWiseProductModel.fromJson(response);
          apiResponse = Response.success(products);
      },
      failureCallback: (message, status) {
        print("this is message error $message $status");
        apiResponse = Response.error(message, status);
      },
    );

    logger.e("api response ${apiResponse?.data}");
    return apiResponse;
  }
  Future<Response<ProductCategoryWiseProductModel?>?> productCategoryWiseItemPass({required Map<String, Object> data}) async {
    Response<ProductCategoryWiseProductModel?>? apiResponse;

    await _dioClient.get(
      path: NetworkConfiguration.productCategoryWiseProduct,
      queryParameters: data,
      responseCallback: (response, message) {
        var products = ProductCategoryWiseProductModel.fromJson(response);
          apiResponse = Response.success(products);
      },
      failureCallback: (message, status) {
        print("this is message error $message $status");
        apiResponse = Response.error(message, status);
      },
    );

    logger.e("api response ${apiResponse?.data}");
    return apiResponse;
  }
  Future<Response<ProductCategoryWiseItemDetails?>?> productCategoryWiseItemDetailsPass({required String itemName}) async {
    Response<ProductCategoryWiseItemDetails?>? apiResponse;
    await _dioClient.get(
      path: NetworkConfiguration.productCategoryWiseItemDetails + itemName,
      // queryParameters: data,
      responseCallback: (response, message) {
        var products = ProductCategoryWiseItemDetails.fromJson(response);
        print("this is products details ${products.itemDetail?.name}");
          apiResponse = Response.success(products);
      },
      failureCallback: (message, status) {
        print("this is message error $message $status");
        apiResponse = Response.error(message, status);
      },
    );

    logger.e("api response ${apiResponse?.data}");
    return apiResponse;
  }
}

