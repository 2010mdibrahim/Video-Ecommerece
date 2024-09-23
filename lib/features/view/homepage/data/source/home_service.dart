import 'package:e_commerce/core/network/configuration.dart';
import 'package:e_commerce/features/view/homepage/data/model/add_to_cart_model.dart';
import '../../../../../../core/di/app_component.dart';
import '../../../../../../core/source/dio_client.dart';
import '../../../../../../core/source/model/api_response.dart';
import '../../../../../../core/source/session_manager.dart';
import '../../../../../../core/utils/constants.dart';
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

}

