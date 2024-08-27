

import '../../../../../../core/source/model/api_response.dart';
import '../../data/model/product_category_model.dart';
import '../../data/model/product_category_wise_item_details.dart';
import '../../data/model/product_category_wise_product_model.dart';
import '../../data/source/product_category_service.dart';
import 'package:dio/dio.dart'as dio;
abstract class ProductCategoryRepository {
  final ProductCategoryService productCategoryService;

  ProductCategoryRepository(this.productCategoryService);

  Future<Response<List<ProductCategoryModel>>?> productCategoryPass();
  Future<Response<ProductCategoryWiseProductModel?>?> productCategoryWiseProductPass();
  Future<Response<ProductCategoryWiseProductModel?>?> productCategoryWiseItemPass({required Map<String, Object> data});
  Future<Response<ProductCategoryWiseItemDetails?>?> productCategoryWiseItemDetailsPass({required String itemName});
}
