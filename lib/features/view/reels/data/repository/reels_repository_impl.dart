import 'package:e_commerce/features/view/my_video_screen/data/model/my_video_model.dart';
import '../../../../../../core/source/model/api_response.dart';
import '../../domain/repository/reels_repository.dart';
import '../model/add_to_cart_model.dart';
import '../model/cart_item_delete_model.dart';
import '../model/like_model.dart';
import '../model/reels_model.dart';
import '../source/reels_service.dart';
class ReelsRepositoryImpl extends ReelsRepository {
  ReelsRepositoryImpl(ReelsService reelsService) : super(reelsService);

  @override
  Future<Response<AllReelsModel>?> reelsPass() async {
    Response<AllReelsModel>? apiResponse;
    apiResponse = await reelsService.reelsPass();
    return apiResponse;
  }

}
class LikeRepositoryImpl extends LikeRepository {
  LikeRepositoryImpl(ReelsService reelsService) : super(reelsService);

  @override
  Future<Response<LikeModel>?> likePass(Map<String, Object> data) async {
    Response<LikeModel>? apiResponse;
    apiResponse = await reelsService.likePass(data);
    return apiResponse;
  }
}
class AddToCartRepositoryImpl extends AddToCartRepository {
  AddToCartRepositoryImpl(super.reelsService);

  @override
  Future<Response<AddToCartModel>?> addToCart(String productId, String cart, String id) async {
    Response<AddToCartModel>? apiResponse;
    apiResponse = await reelsService.addToCart(productId, cart, id);
    return apiResponse;
  }
}
class RemoveToCartRepositoryImpl extends RemoveToCartRepository {
  RemoveToCartRepositoryImpl(super.reelsService);

  @override
  Future<Response<CartItemDeleteModel>?> removeToCart(String productId, String cart) async {
    Response<CartItemDeleteModel>? apiResponse;
    apiResponse = await reelsService.removeToCart(productId, cart);
    return apiResponse;
  }
}
