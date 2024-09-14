import 'package:e_commerce/core/network/configuration.dart';
import '../../../../../../core/di/app_component.dart';
import '../../../../../../core/source/dio_client.dart';
import '../../../../../../core/source/model/api_response.dart';
import '../../../../../../core/source/session_manager.dart';
import '../../../../../../core/utils/constants.dart';
import '../model/my_video_model.dart';
var session = locator<SessionManager>();

class MyVideoService {
  final DioClient _dioClient = locator<DioClient>();

  Future<Response<MyVideosModel>?> myVideoPass() async {
    Response<MyVideosModel>? apiResponse;

    await _dioClient.get(
      path: NetworkConfiguration.myVideo,
      responseCallback: (response, message) {
        var products = MyVideosModel.fromJson(response);
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

