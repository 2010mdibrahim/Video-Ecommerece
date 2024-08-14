import 'package:flutter/material.dart';
import '../../../../../core/routes/route_name.dart';
import '../../../../../core/routes/router.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      RouteGenerator.pushNamedAndRemoveAll(context, Routes.signInPage);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 9,
            child: Center(
              child: Image.asset(
                AppAssets.logo,
                height: 200,
                width: 200,
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}