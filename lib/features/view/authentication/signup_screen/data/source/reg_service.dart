
import 'dart:convert';
import 'package:e_commerce/core/network/configuration.dart';
import 'package:e_commerce/features/view/authentication/sign_in/data/model/user_info_model.dart';
import 'package:e_commerce/features/widget/custom_toast/custom_toast.dart';
import 'package:e_commerce/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../../core/di/app_component.dart';
import '../../../../../../core/source/dio_client.dart';
import '../../../../../../core/source/model/api_response.dart';
import '../../../../../../core/source/session_manager.dart';
import '../../../../../../core/utils/constants.dart';
import '../model/registration_model.dart';
import 'package:dio/dio.dart' as dio;
var session = locator<SessionManager>();

class RegService {
  final DioClient _dioClient = locator<DioClient>();

  Future<Response<RegistrationModel>?> regPass(dio.FormData data) async {
    Response<RegistrationModel>? apiResponse;


   await _dioClient.post(
      path: NetworkConfiguration.reg,
      request: data,
      responseCallback: (response, message) {

        print("this is message $message ${json.encode(response['message'])}");
        // Check if the message is a map
        String? errorMessage;

        // Log the response for debugging
        print("Response: $response");
        print("Message: $message");

        // Check if the response contains errors
        if (response['status'] == 0 && response['message'] is Map<String, dynamic>) {
          // Extract error message from the map
          var errorMap = response['message'] as Map<String, dynamic>;
          if (errorMap.isNotEmpty) {
            var firstErrorList = errorMap.values.first;
            if (firstErrorList is List && firstErrorList.isNotEmpty) {
              errorMessage = firstErrorList.first.toString(); // Get the first error message
            }
          }
        }

        if (errorMessage != null) {
          // Show the error message as a toast
          // Fluttertoast.showToast(msg: errorMessage, toastLength: Toast.LENGTH_LONG);
          errorToast(context: navigatorKey.currentContext!, msg: errorMessage);
        } else {
          // Handle successful response
          var registrationModel = RegistrationModel.fromJson(response);
          apiResponse = Response.success(registrationModel);
        }

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
