import '../../../../../../core/source/model/api_response.dart';
import '../../data/model/add_by_one_model.dart';
import '../../data/model/add_to_cart_model.dart';
import '../../data/model/cashon_delivery_model.dart';
import '../../data/model/checkout_model.dart';
import '../../data/model/coupon_code_model.dart';
import 'home_usecase.dart';

class HomePassUseCase extends HomeUseCase {
  HomePassUseCase(super.homeRepository);

  Future<Response<HomeAddToCartModel>?> call({required Map<String, Object> data}) async {
    var response = await homeRepository.addToCart(data: data);
    return response;
  }
}
class AddByPassUseCase extends HomeUseCase {
  AddByPassUseCase(super.homeRepository);

  Future<Response<AddByOneModel>?> call({required Map<String, Object> data}) async {
    var response = await homeRepository.addbyone(data: data);
    return response;
  }
}
class CheckOutPassUseCase extends HomeUseCase {
  CheckOutPassUseCase(super.homeRepository);

  Future<Response<CheckoutModel>?> call({required Map<String, Object> data}) async {
    var response = await homeRepository.checkout(data: data);
    return response;
  }
}
class CouponCodePassUseCase extends HomeUseCase {
  CouponCodePassUseCase(super.homeRepository);

  Future<Response<CouponCodeModel>?> call({required Map<String, Object> data}) async {
    var response = await homeRepository.couponCode(data: data);
    return response;
  }
}
class CashOnDeliveryPassUseCase extends HomeUseCase {
  CashOnDeliveryPassUseCase(super.homeRepository);

  Future<Response<CashonDeliveryModel>?> call({required Map<String, Object> data}) async {
    var response = await homeRepository.cashOnDelivery(data: data);
    return response;
  }
}

