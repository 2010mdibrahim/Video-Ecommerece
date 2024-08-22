import 'package:e_commerce/features/view/authentication/sign_in/presentation/controller/signin_controller.dart';
import 'package:get/get.dart';
import '../../../../../core/di/app_component.dart';
import '../../../../../core/routes/route_name.dart';
import '../../../../../core/routes/router.dart';
import '../../../../../core/source/dio_client.dart';
import '../../../../../main.dart';

class SplashScreenController extends GetxController{
var signInController = locator<SigninController>();
  @override
  void onInit() {
    checkApplicationInformation();
    super.onInit();
  }

void checkApplicationInformation()async{
  Future.delayed(const Duration(seconds: 3), () async {
  if((session.getEmail?.isNotEmpty ?? false) && (session.getPassword?.isNotEmpty ?? false)){
    signInController.submitLoginData(navigatorKey.currentContext!);
  }else{
      RouteGenerator.pushNamedAndRemoveAll(
          navigatorKey.currentContext!, Routes.signInPage);
  }
  });

}

}