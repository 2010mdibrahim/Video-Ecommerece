import 'package:e_commerce/core/routes/route_name.dart';
import 'package:e_commerce/features/view/all_product/presentation/view/all_product_screen.dart';
import 'package:e_commerce/features/view/homepage/presentation/view/homepage.dart';
import 'package:flutter/material.dart';
import '../../features/view/all_product/presentation/view/product_category_wise.dart';
import '../../features/view/all_product/presentation/view/product_details_page.dart';
import '../../features/view/authentication/sign_in/presentation/view/sign_in_page.dart';
import '../../features/view/authentication/signup_screen/presentation/view/signup_screen.dart';
import '../../features/view/my_video_screen/presentation/view/my_video_screen.dart';
import '../../features/view/send_money_screen/presentation/view/send_money_screen.dart';
import '../../features/view/send_money_screen/presentation/view/transfer_money_history.dart';
import '../../features/view/splash_screen/presentation/view/splash_screen.dart';
import '../../features/view/wallet_screen/presentation/view/wallet_screen.dart';


class RouteGenerator {
  static pushNamed(BuildContext context, String pageName, {dynamic arguments}) {
    return Navigator.pushNamed(context, pageName, arguments: arguments);
  }

  Future<dynamic> pushNamedSms(BuildContext context, String pageName,
      {List arguments = const []}) {
    return Navigator.pushNamed(context, pageName, arguments: arguments);
  }

  static pushNamedforAdvanceSearch(
      BuildContext context, String pageName, Function filterActionEvent) {
    return Navigator.of(context).pushNamed(pageName);
  }

  static pushNamedAndRemoveAll(BuildContext context, String pageName,
      {List arguments = const []}) {
    return Navigator.pushNamedAndRemoveUntil(
        context, pageName, (route) => false,
        arguments: arguments);
  }

  static pushReplacementNamed(BuildContext context, String pageName,
      {List arguments = const []}) {
    return Navigator.pushReplacementNamed(context, pageName,
        arguments: arguments);
  }

  static pop(BuildContext context) {
    return Navigator.of(context).pop();
  }

  // static gotoAdvanceSearchPage(BuildContext context, pgState) {
  //   Navigator.push(context,
  //       MaterialPageRoute(builder: (context) => const AdvanceSearchPage()));
  // }

  // static gotoWebPage(
  //     {required BuildContext context,
  //     String? pageTitle,
  //     required String url,
  //     bool? answerSheet,
  //     int? applicantIndex,
  //     required isSessionNeeded}) {
  //   return Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => WebPage(
  //           pageTitle: pageTitle,
  //           url: url,
  //           answerSheet: answerSheet,
  //           isSessionNeeded: isSessionNeeded,
  //           applicantIndex: applicantIndex),
  //     ),
  //   );
  // }

  static popAndPushNamed(BuildContext context, String pageName,
      {List arguments = const []}) {
    return Navigator.popAndPushNamed(context, pageName, arguments: arguments);
  }

  static popAll(BuildContext context) {
    return Navigator.of(context).popUntil((route) => false);
  }

  static popUntil(BuildContext context, String pageName) {
    return Navigator.of(context).popUntil(ModalRoute.withName(pageName));
  }

  // ================================== Routing =============================================

  static Route<dynamic>? onRouteGenerate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashScreenRouteName:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.signInPage:
        return MaterialPageRoute(
          builder: (context) =>  SignInPage(),
        );
        case Routes.signupPage:
        return MaterialPageRoute(
          builder: (context) =>  SignupScreen(),
        );
        case Routes.homepage:
        return MaterialPageRoute(
          builder: (context) =>  Homepage(),
        );
        case Routes.allProducts:
        return MaterialPageRoute(
          builder: (context) =>  AllProductScreen(),
        );
        case Routes.productCategoryWise:
        return MaterialPageRoute(
          builder: (context) =>  ProductDetailsScreen(),
        );
        case Routes.productCategoryItemDetailsWise:
        return MaterialPageRoute(
          builder: (context) =>  ProductDetailsPage(),
        );
        case Routes.wallet:
        return MaterialPageRoute(
          builder: (context) =>  WalletScreen(),
        );
        case Routes.sendMoney:
        return MaterialPageRoute(
          builder: (context) =>  SendMoneyScreen(),
        );
        case Routes.transferMoneyHistory:
        return MaterialPageRoute(
          builder: (context) =>  TransferMoneyHistory(),
        );
        case Routes.myVideo:
        return MaterialPageRoute(
          builder: (context) =>  MyVideoScreen(),
        );


    }
    return null;
  }
}
