

import '../../../../../../core/source/model/api_response.dart';
import '../../data/model/add_to_cart_model.dart';
import '../../data/model/cart_item_delete_model.dart';
import '../../data/model/like_model.dart';
import '../../data/model/reels_model.dart';
import '../../data/source/reels_service.dart';
abstract class ReelsRepository {
  final ReelsService reelsService;

  ReelsRepository(this.reelsService);

  Future<Response<AllReelsModel>?> reelsPass();
}
abstract class LikeRepository {
  final ReelsService reelsService;

  LikeRepository(this.reelsService);

  Future<Response<LikeModel>?> likePass(Map<String, Object> data);
}
abstract class AddToCartRepository {
  final ReelsService reelsService;

  AddToCartRepository(this.reelsService);

  Future<Response<AddToCartModel>?> addToCart(String productId, String cart, String id);
}
abstract class RemoveToCartRepository {
  final ReelsService reelsService;

  RemoveToCartRepository(this.reelsService);

  Future<Response<CartItemDeleteModel>?> removeToCart(String productId, String cart);
}
