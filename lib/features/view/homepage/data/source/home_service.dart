import 'package:e_commerce/core/network/configuration.dart';
import 'package:e_commerce/features/view/homepage/data/model/add_by_one_model.dart';
import 'package:e_commerce/features/view/homepage/data/model/add_to_cart_model.dart';
import '../../../../../../core/di/app_component.dart';
import '../../../../../../core/source/dio_client.dart';
import '../../../../../../core/source/model/api_response.dart';
import '../../../../../../core/source/session_manager.dart';
import '../../../../../../core/utils/constants.dart';
import '../model/cashon_delivery_model.dart';
import '../model/checkout_model.dart';
import '../model/coupon_code_model.dart';
import '../model/frient_list_model.dart';
import '../model/my_wallet_model.dart';
var session = locator<SessionManager>();

class HomeService {
  final DioClient _dioClient = locator<DioClient>();

  Future<Response<HomeAddToCartModel>?> addToCart( {required Map<String, Object> data}) async {
    Response<HomeAddToCartModel>? apiResponse;

    await _dioClient.get(
      path: NetworkConfiguration.carts,
      queryParameters: data,
      responseCallback: (response, message) {
        var products = HomeAddToCartModel.fromJson(response);
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
  Future<Response<AddByOneModel>?> addbyone( {required Map<String, Object> data}) async {
    Response<AddByOneModel>? apiResponse;
    print("data a ${data['itemid']}");
    await _dioClient.get(
      path: data['type'] == "increment" ? NetworkConfiguration.addbyone : NetworkConfiguration.reducebyone,
      queryParameters: data,
      responseCallback: (response, message) {
        var products = AddByOneModel.fromJson(response);
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
  Future<Response<CheckoutModel>?> checkout( {required Map<String, Object> data}) async {
    Response<CheckoutModel>? apiResponse;
    await _dioClient.post(
      path: NetworkConfiguration.checkout,
      request: data,
      responseCallback: (response, message) {
        var products = CheckoutModel.fromJson(response);
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
  Future<Response<CouponCodeModel>?> couponCode( {required Map<String, Object> data}) async {
    Response<CouponCodeModel>? apiResponse;
    await _dioClient.post(
      path: NetworkConfiguration.couponCheck,
      request: data,
      responseCallback: (response, message) {
        var products = CouponCodeModel.fromJson(response);
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
  Future<Response<CashonDeliveryModel>?> cashOnDelivery( {required Map<String, Object> data}) async {
    Response<CashonDeliveryModel>? apiResponse;
    await _dioClient.post(
      path: NetworkConfiguration.cashondelivery,
      request: data,
      responseCallback: (response, message) {
        var products = CashonDeliveryModel.fromJson(response);
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

  Future<Response<FriendListModel>?> frientList() async {
    Response<FriendListModel>? apiResponse;

    await _dioClient.get(
      path: NetworkConfiguration.frientList,
      responseCallback: (response, message) {
        var products = FriendListModel.fromJson(response);
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
  Future<Response<MyWalletModel>?> myWallet() async {
    Response<MyWalletModel>? apiResponse;

    await _dioClient.get(
      path: NetworkConfiguration.myWallet,
      responseCallback: (response, message) {
        var products = MyWalletModel.fromJson(response);
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

