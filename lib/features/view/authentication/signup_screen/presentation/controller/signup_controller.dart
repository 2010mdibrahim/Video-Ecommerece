import 'dart:io';

import 'package:e_commerce/features/widget/custom_toast/custom_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart' as dio;
import 'dart:io';

import '../../../../../../core/di/app_component.dart';
import '../../../../../../core/routes/route_name.dart';
import '../../../../../../core/routes/router.dart';
import '../../../../../../core/source/dio_client.dart';
import '../../../../../../main.dart';
import '../../domain/repository/reg_repository.dart';
import '../../domain/usecase/reg_pass_usecase.dart';

class SignupController extends GetxController{
  var obscureTextPassword = true.obs;
  var obscureTextConfirmPassword = true.obs;
  var emailController = TextEditingController(text: "mehedi3@gmail.com").obs;
  var firstName = TextEditingController(text: "mehedi").obs;
  var lastName = TextEditingController(text: "hasan").obs;
  var phoneNumber = TextEditingController(text: "012345678221").obs;
  var addressController = TextEditingController(text: "test").obs;
  var confirmPasswordController = TextEditingController(text: "12345678").obs;
  var passwordController = TextEditingController(text: "12345678").obs;
  final ImagePicker picker = ImagePicker();
  var pickedImage = File("").obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }
  submitSignupData(BuildContext context) async {
    if(firstName.value.text.isEmpty){
      errorToast(context: context, msg: "Please enter first name");
    }else if(lastName.value.text.isEmpty){
      errorToast(context: context, msg: "Please enter last name");
    }else if(emailController.value.text.isEmpty){
      errorToast(context: context, msg: "Please  enter email");
    }else if(phoneNumber.value.text.isEmpty){
      errorToast(context: context, msg: "Please enter phone number");
    }else if(addressController.value.text.isEmpty){
      errorToast(context: context, msg: "Please enter address");
    }else if(passwordController.value.text.isEmpty){
      errorToast(context: context, msg: "Please enter password");
    }else if(confirmPasswordController.value.text != passwordController.value.text){
      errorToast(context: context, msg: "Password is not matched with confirmation password");
    } else if(pickedImage.value.path.isEmpty){
      errorToast(context: context, msg: "Please insert an image");
    }else{
      try {
        isLoading.value = true;
        RegPassUseCase signUpPassUseCase =
        RegPassUseCase(locator<RegRepository>());
        dio.FormData formData = dio.FormData.fromMap({
          "name": "${firstName.value.text} ${lastName.value.text}",
          "email": emailController.value.text,
          "phone": phoneNumber.value.text,
          "address": addressController.value.text,
          "password": passwordController.value.text,
          "password_confirmation": confirmPasswordController.value.text,
          "photo": await dio.MultipartFile.fromFile(
            pickedImage.value.path,
            filename: pickedImage.value.path.split('/').last, // Get the file name
          ),
        });
        forCheck(formData);
        var response = await signUpPassUseCase(formData);
        if (response?.data != null && response?.data?.message == "Registration Successfull!"){
          print("this is not here");
          successToast(context: context, msg: "Successfully sign up");
          session.setToken = response?.data?.token;
          isLoading.value = false;
          RouteGenerator.pushNamedAndRemoveAll(context, Routes.homepage);
        }
      } catch (e) {
        print(e.toString());
        // errorToast(context: context, msg: e.toString());
      }finally{
        isLoading.value = false;
      }
    }
}
forCheck(dio.FormData formData){}
  Future<void> pickImageCamera() async {
    if (await Permission.storage.request().isGranted) {
      XFile? xFile = await picker.pickImage(source: ImageSource.camera);
      if (xFile != null) {
        pickedImage.value = File(xFile.path);
        Navigator.pop(navigatorKey.currentContext!);
        print(pickedImage);
        update();
      }
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.storage.request().isDenied) {
      await Permission.storage.request();
    }
    update();
  }
  Future<void> pickImageFromGallery() async {
    if (await Permission.storage.request().isGranted) {
      XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
      if (xFile != null) {
        pickedImage.value = File(xFile.path);
        print(pickedImage);
        Navigator.pop(navigatorKey.currentContext!);
        update();
      }
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.storage.request().isDenied) {
      await Permission.storage.request();
    }
    update();
  }

}