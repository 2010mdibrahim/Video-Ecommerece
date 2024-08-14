import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController{
  var obscureTextPassword = true.obs;
  var obscureTextConfirmPassword = true.obs;
  var emailController = TextEditingController().obs;
  var firstName = TextEditingController().obs;
  var lastName = TextEditingController().obs;
  var confirmPasswordController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
}