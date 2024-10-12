import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'core/di/app_component.dart';
import 'core/routes/router.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "VideoMart",
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   scaffoldBackgroundColor: Colors.white,
      //   primarySwatch: ColorResources.CORPORATE_BLUE_SWATCH,
      // ),
      onGenerateRoute: RouteGenerator.onRouteGenerate,
    );
  }
}

