

import '../../../../../../core/source/model/api_response.dart';
import '../../data/model/add_by_one_model.dart';
import '../../data/model/add_to_cart_model.dart';
import '../../data/model/cashon_delivery_model.dart';
import '../../data/model/checkout_model.dart';
import '../../data/model/coupon_code_model.dart';
import '../../data/model/frient_list_model.dart';
import '../../data/model/my_wallet_model.dart';
import '../../data/source/home_service.dart';
abstract class HomeRepository {
  final HomeService myVideoService;

  HomeRepository(this.myVideoService);

  Future<Response<HomeAddToCartModel>?> addToCart({required Map<String, Object> data});
  Future<Response<AddByOneModel>?> addbyone({required Map<String, Object> data});
  Future<Response<CheckoutModel>?> checkout({required Map<String, Object> data});
  Future<Response<CouponCodeModel>?> couponCode({required Map<String, Object> data});
  Future<Response<CashonDeliveryModel>?> cashOnDelivery({required Map<String, Object> data});
  Future<Response<FriendListModel>?> frientList();
  Future<Response<MyWalletModel>?> myWallet();
}
