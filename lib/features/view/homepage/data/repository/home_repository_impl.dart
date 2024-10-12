import 'package:e_commerce/features/view/homepage/data/model/add_to_cart_model.dart';

import '../../../../../../core/source/model/api_response.dart';
import '../../domain/repository/home_repository.dart';
import '../model/add_by_one_model.dart';
import '../model/cashon_delivery_model.dart';
import '../model/checkout_model.dart';
import '../model/coupon_code_model.dart';
import '../model/frient_list_model.dart';
import '../model/my_wallet_model.dart';
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
  @override
  Future<Response<AddByOneModel>?> addbyone(
      {required Map<String, Object> data}) async {
    Response<AddByOneModel>? apiResponse;
    apiResponse = await myVideoService.addbyone(data: data);
    return apiResponse;
  }
  @override
  Future<Response<CheckoutModel>?> checkout(
      {required Map<String, Object> data}) async {
    Response<CheckoutModel>? apiResponse;
    apiResponse = await myVideoService.checkout(data: data);
    return apiResponse;
  }
  @override
  Future<Response<CouponCodeModel>?> couponCode(
      {required Map<String, Object> data}) async {
    Response<CouponCodeModel>? apiResponse;
    apiResponse = await myVideoService.couponCode(data: data);
    return apiResponse;
  }
  @override
  Future<Response<CashonDeliveryModel>?> cashOnDelivery(
      {required Map<String, Object> data}) async {
    Response<CashonDeliveryModel>? apiResponse;
    apiResponse = await myVideoService.cashOnDelivery(data: data);
    return apiResponse;
  }
  @override
  Future<Response<FriendListModel>?> frientList() async {
    Response<FriendListModel>? apiResponse;
    apiResponse = await myVideoService.frientList();
    return apiResponse;
  }
  @override
  Future<Response<MyWalletModel>?> myWallet() async {
    Response<MyWalletModel>? apiResponse;
    apiResponse = await myVideoService.myWallet();
    return apiResponse;
  }
}
