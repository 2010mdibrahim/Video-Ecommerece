import 'package:e_commerce/features/view/authentication/sign_in/data/model/user_info_model.dart';

import '../../../../../../core/source/model/api_response.dart';
import '../../domain/repository/login_repository.dart';
import '../model/login_model.dart';
import '../source/login_service.dart';

class SignInRepositoryImpl extends SignInRepository {
  SignInRepositoryImpl(SignInService loginService) : super(loginService);

  @override
  Future<Response<LoginModel?>?> loginWithIdPass(
      {required String userName, required String password}) async {
    Response<LoginModel>? apiResponse;
    apiResponse = await loginService.loginWithIdPass(userName, password);
    return apiResponse;
  }
  @override
  Future<Response<UserInformationModel?>?> userInfoPass() async {
    Response<UserInformationModel>? apiResponse;
    apiResponse = await loginService.userInfoPass();
    return apiResponse;
  }
}
