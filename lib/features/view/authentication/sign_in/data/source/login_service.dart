
import 'dart:convert';
import 'package:e_commerce/core/network/configuration.dart';
import 'package:e_commerce/features/view/authentication/sign_in/data/model/user_info_model.dart';

import '../../../../../../core/di/app_component.dart';
import '../../../../../../core/source/dio_client.dart';
import '../../../../../../core/source/model/api_response.dart';
import '../../../../../../core/source/session_manager.dart';
import '../../../../../../core/utils/constants.dart';
import '../model/login_model.dart';
import 'package:dio/dio.dart' as dio;
var session = locator<SessionManager>();

class SignInService {
  final DioClient _dioClient = locator<DioClient>();

  Future<Response<LoginModel>?> loginWithIdPass(
      String id, String password) async {
    Response<LoginModel>? apiResponse;

    var formData = {
      "email": id,
      "password": password,
    };
   await _dioClient.post(
      path: NetworkConfiguration.login,
      request: formData,
      responseCallback: (response, message) {
        var loginModel = LoginModel.fromJson(response);
        // Create a Response object with the parsed data
        apiResponse = Response.success(loginModel);
        logger.i("Login successful: $loginModel");
      },
      failureCallback: (message, status) {
        apiResponse = Response.error(message, status);
      },
    );


    logger.e("api response ${apiResponse?.data}");
    return apiResponse;
  }

  Future<Response<UserInformationModel>?> userInfoPass() async {
    Response<UserInformationModel>? apiResponse;

   await _dioClient.get(
     isNeedToken: true,
      path: NetworkConfiguration.userInformation,
      // request: formData,
      responseCallback: (response, message) {
        var loginModel = UserInformationModel.fromJson(response);
        // Create a Response object with the parsed data
        apiResponse = Response.success(loginModel);
        logger.i("user info: $loginModel");
      },
      failureCallback: (message, status) {
        apiResponse = Response.error(message, status);
      },
    );


    logger.e("api response ${apiResponse?.data}");
    return apiResponse;
  }
}
