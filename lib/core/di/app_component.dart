import 'package:dio/dio.dart';
import 'package:e_commerce/features/view/authentication/sign_in/presentation/controller/signin_controller.dart';
import 'package:e_commerce/features/view/splash_screen/presentation/controller/splash_controller.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/view/authentication/sign_in/data/repository/login_repository_impl.dart';
import '../../features/view/authentication/sign_in/data/source/login_service.dart';
import '../../features/view/authentication/sign_in/domain/repository/login_repository.dart';
import '../source/dio_client.dart';
import '../source/pref_manager.dart';
import '../source/session_manager.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerFactory<Dio>(
      () => Dio()..interceptors.add(InterceptorsWrapper()));
  locator.registerFactory<DioClient>(() => DioClient(locator<Dio>()));
  //login
  locator.registerFactory<SigninController>(() => Get.put(SigninController()));
  locator.registerFactory<SignInService>(() => SignInService());
  locator.registerFactory<SignInRepository>(
      () => SignInRepositoryImpl(locator<SignInService>()));


//splash screen controller
  locator.registerFactory<SplashScreenController>(() => Get.put(SplashScreenController()));
  //session
  locator.registerSingletonAsync<SessionManager>(() async =>
      SessionManager(PrefManager(await SharedPreferences.getInstance())));
}
