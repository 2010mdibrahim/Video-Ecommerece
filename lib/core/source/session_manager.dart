import 'dart:io';

import 'package:e_commerce/core/source/pref_manager.dart';
import 'package:e_commerce/features/view/authentication/sign_in/data/model/user_info_model.dart';

import '../../features/view/authentication/sign_in/data/model/login_model.dart';



class SessionManager {
  Future<bool> createSession(LoginModel? loginModelData, { String? phoneNumber,  String? password}) async {
    print("this is session ${loginModelData?.token}");
    try {
      // if(loginModelData?.type == "employee"){
      //   setFullName = loginModelData?.candidate?.fullName;
      //   setPassword = password;
      //   setPhoneNumber = phoneNumber;
      //   setPhoto = loginModelData?.candidate?.avaterPhoto;
      // }else{
      print("this is session ${loginModelData?.token}");
        setToken = loginModelData?.token;
        // setPhoto = loginModelData?.candidate?.candidatePhoto;
      // }
      // print(loginModelData?.candidate?.id);
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> createUserSession(UserInformationModel? userInfo, { String? phoneNumber,  String? password}) async {
    print("this is session ${userInfo?.name}");
    try {
      // if(loginModelData?.type == "employee"){
      //   setFullName = loginModelData?.candidate?.fullName;
      //   setPassword = password;
      //   setPhoneNumber = phoneNumber;
      //   setPhoto = loginModelData?.candidate?.avaterPhoto;
      // }else{
      print("this is session ${userInfo?.name}");
        setFullName = userInfo?.name;
        setEmail = userInfo?.email;
        setPhoneNumber = phoneNumber;
        // setPhoto = loginModelData?.candidate?.candidatePhoto;
      // }
      // print(loginModelData?.candidate?.id);
      return true;
    } catch (e) {
      return false;
    }
  }


  final PrefManager _prefManager;

  SessionManager(this._prefManager);

  String? get getFullName =>
      _prefManager.getStringValue("fullName");
  set setFullName(String? value) => _prefManager.saveString(
      "fullName", value ?? "");

  String? get getUserPID =>
      _prefManager.getStringValue("userPID");
  set setUserPID(String? value) => _prefManager.saveString(
      "userPID", value ?? "");

  String? get getPassword =>
      _prefManager.getStringValue("password");
  set setPassword(String? value) => _prefManager.saveString(
      "password", value ?? "");

  String? get getEmail =>
      _prefManager.getStringValue("email");
  set setEmail(String? value) => _prefManager.saveString(
      "email", value ?? "");

  String? get getPhoneNumber =>
      _prefManager.getStringValue("phoneNumber");
  set setPhoneNumber(String? value) => _prefManager.saveString(
      "phoneNumber", value ?? "");


  String? get getPhoto =>
      _prefManager.getStringValue("photo");
  set setPhoto(String? value) => _prefManager.saveString(
      "photo", value ?? "");


set setBaseUrl(String? value)=> _prefManager.saveString("baseUrl", value);
  String? get getBaseUrl =>
      _prefManager.getStringValue("baseUrl");
  set setToken(String? value)=> _prefManager.saveString("token", value);
  String? get getToken =>
      _prefManager.getStringValue("token");

  set setCandidateId(String? value)=> _prefManager.saveString("candidateId", value);
  String? get getCandidateId =>
      _prefManager.getStringValue("candidateId");

  String? get getDeviceId =>
      _prefManager.getStringValue("deviceId");
  set setDeviceId(String? value) => _prefManager.saveString(
      "deviceId", value ?? "");

  Future<bool> logout() async {
    bool response = false;
    await _prefManager.logOut().whenComplete(() {
      response = true;
    });
    return response;
  }
}
