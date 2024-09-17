import 'package:e_commerce/core/network/configuration.dart';
import '../../../../../../core/di/app_component.dart';
import '../../../../../../core/source/dio_client.dart';
import '../../../../../../core/source/model/api_response.dart';
import '../../../../../../core/source/session_manager.dart';
import '../../../../../../core/utils/constants.dart';
import '../model/like_model.dart';
import '../model/reels_model.dart';
var session = locator<SessionManager>();

class ReelsService {
  final DioClient _dioClient = locator<DioClient>();

  Future<Response<AllReelsModel>?> reelsPass() async {
    Response<AllReelsModel>? apiResponse;

    await _dioClient.get(
      path: NetworkConfiguration.myVideo,
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

}

