import 'package:dio/dio.dart';
import 'package:e_commerce/features/view/all_product/data/repository/product_category_repository_impl.dart';
import 'package:e_commerce/features/view/all_product/data/source/product_category_service.dart';
import 'package:e_commerce/features/view/all_product/domain/repository/product_category_repository.dart';
import 'package:e_commerce/features/view/all_product/presentation/controller/all_product_controller.dart';
import 'package:e_commerce/features/view/authentication/sign_in/presentation/controller/signin_controller.dart';
import 'package:e_commerce/features/view/authentication/signup_screen/data/repository/reg_repository_impl.dart';
import 'package:e_commerce/features/view/authentication/signup_screen/data/source/reg_service.dart';
import 'package:e_commerce/features/view/authentication/signup_screen/domain/repository/reg_repository.dart';
import 'package:e_commerce/features/view/authentication/signup_screen/presentation/controller/signup_controller.dart';
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
  //sign up
  locator.registerFactory<SignupController>(() => Get.put(SignupController()));
  locator.registerFactory<RegService>(() => RegService());
  locator.registerFactory<RegRepository>(
      () => RegRepositoryImpl(locator<RegService>()));
  //Product Category
  locator.registerFactory<AllProductController>(() => Get.put(AllProductController()));
  locator.registerFactory<ProductCategoryService>(() => ProductCategoryService());
  locator.registerFactory<ProductCategoryRepository>(
      () => ProductCategoryRepositoryImpl(locator<ProductCategoryService>()));


//splash screen controller
  locator.registerFactory<SplashScreenController>(() => Get.put(SplashScreenController()));
  //session
  locator.registerSingletonAsync<SessionManager>(() async =>
      SessionManager(PrefManager(await SharedPreferences.getInstance())));
}
