import 'package:e_commerce/features/view/authentication/sign_in/data/model/user_info_model.dart';

import '../../../../../../core/source/model/api_response.dart';
import '../../domain/repository/product_category_repository.dart';
import '../model/product_category_model.dart';
import '../model/product_category_wise_item_details.dart';
import '../model/product_category_wise_product_model.dart';
import '../source/product_category_service.dart';
import 'package:dio/dio.dart'as dio;
class ProductCategoryRepositoryImpl extends ProductCategoryRepository {
  ProductCategoryRepositoryImpl(ProductCategoryService productCategoryService) : super(productCategoryService);

  @override
  Future<Response<List<ProductCategoryModel>>?> productCategoryPass() async {
    Response<List<ProductCategoryModel>>? apiResponse;
    apiResponse = await productCategoryService.productCategoryPass();
    return apiResponse;
  }
  @override
  Future<Response<ProductCategoryWiseProductModel?>?>productCategoryWiseProductPass() async {
    Response<ProductCategoryWiseProductModel?>? apiResponse;
    apiResponse = await productCategoryService.productCategoryWiseProductPass();
    return apiResponse;
  }
  @override
  Future<Response<ProductCategoryWiseProductModel?>?>productCategoryWiseItemPass({required Map<String, Object> data}) async {
    Response<ProductCategoryWiseProductModel?>? apiResponse;
    apiResponse = await productCategoryService.productCategoryWiseItemPass(data: data);
    return apiResponse;
  }
  @override
  Future<Response<ProductCategoryWiseItemDetails?>?>productCategoryWiseItemDetailsPass({required String itemName}) async {
    Response<ProductCategoryWiseItemDetails?>? apiResponse;
    apiResponse = await productCategoryService.productCategoryWiseItemDetailsPass(itemName: itemName);
    return apiResponse;
  }

}
