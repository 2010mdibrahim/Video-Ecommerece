import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../../core/routes/route_name.dart';
import '../../../../../../core/routes/router.dart';
import '../../../../../../core/source/dio_client.dart';
import '../../../../../../main.dart';

class SignupController extends GetxController{
  var obscureTextPassword = true.obs;
  var obscureTextConfirmPassword = true.obs;
  var emailController = TextEditingController().obs;
  var firstName = TextEditingController().obs;
  var lastName = TextEditingController().obs;
  var confirmPasswordController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;

  @override
  void onInit() {
    checkApplicationInformation();
    super.onInit();
  }

  void checkApplicationInformation()async{

    // session.setDeviceId = androidInfo.id;
    Future.delayed(const Duration(seconds: 3), () async {
      if((session.getPhoneNumber?.isNotEmpty ?? false) && (session.getPassword?.isNotEmpty ?? false)){

        RouteGenerator.pushNamedAndRemoveAll(
            navigatorKey.currentContext!, Routes.homepage);
      }else{
        RouteGenerator.pushNamedAndRemoveAll(
            navigatorKey.currentContext!, Routes.signInPage);
      }
    });



  }

}