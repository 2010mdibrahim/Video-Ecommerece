import 'package:get/get.dart';
import '../../../../../core/routes/route_name.dart';
import '../../../../../core/routes/router.dart';
import '../../../../../core/source/dio_client.dart';
import '../../../../../main.dart';

class SplashScreenController extends GetxController{

  @override
  void onInit() {
    checkApplicationInformation();
    super.onInit();
  }

void checkApplicationInformation()async{



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