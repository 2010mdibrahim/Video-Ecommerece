import 'package:e_commerce/core/network/configuration.dart';
import '../../../../../../core/di/app_component.dart';
import '../../../../../../core/source/dio_client.dart';
import '../../../../../../core/source/model/api_response.dart';
import '../../../../../../core/source/session_manager.dart';
import '../../../../../../core/utils/constants.dart';
import '../model/add_to_cart_model.dart';
import '../model/cart_item_delete_model.dart';
import '../model/like_model.dart';
import '../model/reels_model.dart';
var session = locator<SessionManager>();

class ReelsService {
  final DioClient _dioClient = locator<DioClient>();

  Future<Response<AllReelsModel>?> reelsPass(Map<String, Object> data) async {
    Response<AllReelsModel>? apiResponse;

    await _dioClient.get(
      path: NetworkConfiguration.getAllVideos,
      queryParameters: data,
      responseCallback: (response, message) {
        var products = AllReelsModel.fromJson(response);
        apiResponse = Response.success(products);
      },
      failureCallback: (message, status) {
        print("this is message error $message $status");
        apiResponse = Response.error(message, status);
      },
    );

    logger.e("api response ${apiResponse?.data}");
    return apiResponse;
  }
  Future<Response<LikeModel>?> likePass(Map<String, Object> data) async {
    Response<LikeModel>? apiResponse;

    await _dioClient.post(
      path: NetworkConfiguration.like,
      request: data,
      responseCallback: (response, message) {
        var products = LikeModel.fromJson(response);
        apiResponse = Response.success(products);
      },
      failureCallback: (message, status) {
        print("this is message error $message $status");
        apiResponse = Response.error(message, status);
      },
    );

    logger.e("api response ${apiResponse?.data}");
    return apiResponse;
  }
  Future<Response<AddToCartModel>?> addToCart(String productId, String cart, String id) async {
    Response<AddToCartModel>? apiResponse;
    print("this iis cart $cart");
    var cartDetails = {
      "cart" : cart,
      "video_id": id,
    };
    await _dioClient.get(
      path: NetworkConfiguration.addToCart + productId,
      queryParameters: cartDetails,
      responseCallback: (response, message) {
        print("thisi is response $response");
        var products = AddToCartModel.fromJson(response);
        apiResponse = Response.success(products);
      },
      failureCallback: (message, status) {
        print("this is message error $message $status");
        apiResponse = Response.error(message, status);
      },
    );

    logger.e("api response ${apiResponse?.data}");
    return apiResponse;
  }
  Future<Response<CartItemDeleteModel>?> removeToCart(String productId, String cart) async {
    Response<CartItemDeleteModel>? apiResponse;
    print("this iis cart arif $cart");
    var cartDetails = {
      "cart" : cart,
    };
    await _dioClient.get(
      path: NetworkConfiguration.removeToCart + productId,
      queryParameters: cartDetails,
      responseCallback: (response, message) {
        var products = CartItemDeleteModel.fromJson(response);
        apiResponse = Response.success(products);
      },
      failureCallback: (message, status) {
        print("this is message error $message $status");
        apiResponse = Response.error(message, status);
      },
    );

    logger.e("api response ${apiResponse?.data}");
    return apiResponse;
  }
}

