import 'package:e_commerce/features/view/homepage/data/model/add_to_cart_model.dart';

import '../../../../../../core/source/model/api_response.dart';
import '../../domain/repository/home_repository.dart';
import '../source/home_service.dart';
class HomeRepositoryImpl extends HomeRepository {
  HomeRepositoryImpl(HomeService homeService) : super(homeService);

  @override
  Future<Response<HomeAddToCartModel>?> addToCart(
      {required Map<String, Object> data}) async {
    Response<HomeAddToCartModel>? apiResponse;
    apiResponse = await myVideoService.addToCart(data: data);
    return apiResponse;
  }
}
