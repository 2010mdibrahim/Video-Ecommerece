

import '../../../../../../core/source/model/api_response.dart';
import '../../data/model/product_category_model.dart';
import '../../data/source/product_category_service.dart';
import 'package:dio/dio.dart'as dio;
abstract class ProductCategoryRepository {
  final ProductCategoryService productCategoryService;

  ProductCategoryRepository(this.productCategoryService);

  Future<Response<List<ProductCategoryModel>>?> productCategoryPass();
}
