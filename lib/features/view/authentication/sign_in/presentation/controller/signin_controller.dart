import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SigninController extends GetxController{
  var obscureText = false.obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
}