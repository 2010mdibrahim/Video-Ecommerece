import 'package:e_commerce/core/source/pref_manager.dart';
import 'package:e_commerce/features/view/authentication/sign_in/data/model/user_info_model.dart';
import '../../features/view/authentication/sign_in/data/model/login_model.dart';

class SessionManager {
  Future<bool> createSession(LoginModel? loginModelData, {String? phoneNumber,  String? password}) async {
    print("this is session ${loginModelData?.token}");
    try {
        setToken = loginModelData?.token;
        setPassword = password;
        setAddress = loginModelData?.data?.address;
        setPhoneNumber = loginModelData?.data?.phone;
        setId = loginModelData?.data?.id.toString();
        setCommissionBalance = loginModelData?.data?.commissionBalance.toString() ?? '';
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> createUserSession(UserInformationModel? userInfo, {String? phoneNumber,  String? password}) async {
    try {
        setFullName = userInfo?.name;
        setEmail = userInfo?.email;

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

  String? get getCommissionBalance =>
      _prefManager.getStringValue("commissionBalance");
  set setCommissionBalance(String? value) => _prefManager.saveString(
      "commissionBalance", value ?? "");

set setBaseUrl(String? value)=> _prefManager.saveString("baseUrl", value);
  String? get getBaseUrl =>
      _prefManager.getStringValue("baseUrl");
  set setToken(String? value)=> _prefManager.saveString("token", value);
  String? get getToken =>
      _prefManager.getStringValue("token");


  String? get getExistingCode =>
      _prefManager.getStringValue("existingCode");
  set setExistingCode(String? value) => _prefManager.saveString(
      "existingCode", value ?? "");

  String? get getAddress =>
      _prefManager.getStringValue("address");
  set setAddress(String? value) => _prefManager.saveString(
      "address", value ?? "");

  String? get getId =>
      _prefManager.getStringValue("userId");
  set setId(String? value) => _prefManager.saveString(
      "userId", value ?? "");

  Future<bool> logout() async {
    bool response = false;
    await _prefManager.logOut().whenComplete(() {
      response = true;
    });
    return response;
  }
}
