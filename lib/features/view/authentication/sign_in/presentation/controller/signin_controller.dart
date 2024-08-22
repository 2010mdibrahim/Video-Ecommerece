import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../../core/di/app_component.dart';
import '../../../../../../core/routes/route_name.dart';
import '../../../../../../core/routes/router.dart';
import '../../../../../../core/source/dio_client.dart';
import '../../../../../widget/custom_toast/custom_toast.dart';
import '../../data/model/login_model.dart';
import '../../domain/repository/login_repository.dart';
import '../../domain/usecase/login_with_id_pass_usecase.dart';

class SigninController extends GetxController {
  var obscureText = false.obs;
  var emailController = TextEditingController(text: "arif@gmail.com").obs;
  var passwordController = TextEditingController(text: "12345678").obs;
  var passwordVisibility = true.obs;
  var errorMessage = ''.obs;
  var isLoading = false.obs;
  passwordVisibilityFun() {
    passwordVisibility.value = !passwordVisibility.value;
    print(passwordVisibility.value);
    update();
  }

  errorMessageHandling(String? s) {
    if (passwordController.value.text.isNotEmpty) {
      errorMessage.value = 'Password must be filled';
    } else {
      errorMessage.value = '';
    }
    update();
  }

  submitLoginData(BuildContext context) async {
    try {
      LoginWithIdPassUseCase loginUseCase =
          LoginWithIdPassUseCase(locator<SignInRepository>());
      UserInfoPassUseCase userinfoUseCase =
          UserInfoPassUseCase(locator<SignInRepository>());
      if (emailController.value.text.isEmpty && (session.getEmail?.isEmpty ?? false)) {
        errorToast(context: context, msg: "Please enter email");
      } else if (passwordController.value.text.isEmpty) {
        errorToast(context: context, msg: "Please enter password");
      } else {
        isLoading.value = true;
        update();
        var response = await loginUseCase(
            userName: session.getEmail ?? emailController.value.text,
            password: session.getPassword ?? passwordController.value.text);
        print("this is data of login ${response?.data?.message}");
        if (response?.data != null) {
          session.createSession(response?.data,
              phoneNumber: emailController.value.text,
              password: passwordController.value.text);
          var userInfo = await userinfoUseCase();
          if (!context.mounted) return;
          session.createUserSession(userInfo?.data);
          print("user info model $userInfo");
          RouteGenerator.pushNamedAndRemoveAll(context, Routes.homepage);
          if (!context.mounted) return;
          successToast(context: context, msg: response?.data?.message ?? '');
        } else {
          if (!context.mounted) return;
          if (response?.data?.status == null) {
            errorToast(context: context, msg: "Invalid login credential!");
          }
        }
      }
    } catch (e) {
      print(e.toString() ?? '');
    } finally {
      isLoading.value = false;
    }
    update();
  }
}
