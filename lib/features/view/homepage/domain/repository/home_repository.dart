

import '../../../../../../core/source/model/api_response.dart';
import '../../data/model/add_to_cart_model.dart';
import '../../data/source/home_service.dart';
abstract class HomeRepository {
  final HomeService myVideoService;

  HomeRepository(this.myVideoService);

  Future<Response<HomeAddToCartModel>?> addToCart({required Map<String, Object> data});
}
