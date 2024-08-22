import 'package:e_commerce/features/view/authentication/sign_in/data/model/user_info_model.dart';

import '../../../../../../core/source/model/api_response.dart';
import '../../domain/repository/product_category_repository.dart';
import '../model/product_category_model.dart';
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

}
