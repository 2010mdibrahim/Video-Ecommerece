
import 'package:dio/dio.dart'as dio;

import '../../../../../../core/source/model/api_response.dart';
import '../../data/model/product_category_model.dart';
import 'product_category_usecase.dart';

class ProductCategoryPassUseCase extends ProductCategoryUseCase {
  ProductCategoryPassUseCase(super.productCategoryRepository);

  Future<Response<List<ProductCategoryModel>>?> call() async {
    var response = await productCategoryRepository.productCategoryPass();
    return response;
  }
}

