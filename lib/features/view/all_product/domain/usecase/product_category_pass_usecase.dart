
import 'package:dio/dio.dart'as dio;

import '../../../../../../core/source/model/api_response.dart';
import '../../data/model/product_category_model.dart';
import '../../data/model/product_category_wise_item_details.dart';
import '../../data/model/product_category_wise_product_model.dart';
import 'product_category_usecase.dart';

class ProductCategoryPassUseCase extends ProductCategoryUseCase {
  ProductCategoryPassUseCase(super.productCategoryRepository);

  Future<Response<List<ProductCategoryModel>>?> call() async {
    var response = await productCategoryRepository.productCategoryPass();
    return response;
  }
}
class ProductCategoryWiseProductPassUseCase extends ProductCategoryWiseProductUseCase {
  ProductCategoryWiseProductPassUseCase(super.productCategoryRepository);

  Future<Response<ProductCategoryWiseProductModel?>?> call() async {
    var response = await productCategoryRepository.productCategoryWiseProductPass();
    return response;
  }
}
class ProductCategoryWiseItemPassUseCase extends ProductCategoryWiseItemUseCase {
  ProductCategoryWiseItemPassUseCase(super.productCategoryRepository);

  Future<Response<ProductCategoryWiseProductModel?>?> call({required Map<String, Object> data}) async {
    var response = await productCategoryRepository.productCategoryWiseItemPass(data: data);
    return response;
  }
}
class ProductCategoryWiseItemDetailsPassUseCase extends ProductCategoryWiseItemDetailsUseCase {
  ProductCategoryWiseItemDetailsPassUseCase(super.productCategoryRepository);

  Future<Response<ProductCategoryWiseItemDetails?>?> call({required String itemName}) async {
    var response = await productCategoryRepository.productCategoryWiseItemDetailsPass(itemName: itemName);
    return response;
  }
}

