import '../../../../../../core/source/model/api_response.dart';
import '../../data/model/add_to_cart_model.dart';
import 'home_usecase.dart';

class HomePassUseCase extends HomeUseCase {
  HomePassUseCase(super.homeRepository);

  Future<Response<HomeAddToCartModel>?> call({required Map<String, Object> data}) async {
    var response = await homeRepository.addToCart(data: data);
    return response;
  }
}

