
import 'package:dio/dio.dart'as dio;

import '../../../../../../core/source/model/api_response.dart';
import '../../data/model/add_to_cart_model.dart';
import '../../data/model/cart_item_delete_model.dart';
import '../../data/model/like_model.dart';
import '../../data/model/reels_model.dart';
import 'reels_usecase.dart';

class ReelsPassUseCase extends ReelsUseCase {
  ReelsPassUseCase(super.reelsRepository);

  Future<Response<AllReelsModel>?> call() async {
    var response = await reelsRepository.reelsPass();
    return response;
  }
}
class LikePassUseCase extends LikeUseCase {
  LikePassUseCase(super.likeRepository);

  Future<Response<LikeModel>?> call(Map<String, Object> data) async {
    var response = await likeRepository.likePass(data);
    return response;
  }
}
class AddToCartPassUseCase extends AddToCartUseCase {
  AddToCartPassUseCase(super.addToCartRepository);

  Future<Response<AddToCartModel>?> call(String productId, String cart, String id) async {
    var response = await addToCartRepository.addToCart(productId, cart, id);
    return response;
  }
}
class RemoveToCartPassUseCase extends RemoveToCartUseCase {
  RemoveToCartPassUseCase(super.removeToCartRepository);

  Future<Response<CartItemDeleteModel>?> call(String productId, String cart) async {
    var response = await removeToCartRepository.removeToCart(productId, cart);
    return response;
  }
}

