import 'package:e_learning/controllers/theme_controller.dart';
import 'package:e_learning/utils/app_pages.dart';
import 'package:e_learning/utils/app_routes.dart';
import 'package:e_learning/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  final themeController = Get.put(ThemeController());
  runApp(MyApp(themeController: themeController));
}

class MyApp extends StatelessWidget {
  final ThemeController themeController;

  const MyApp({super.key, required this.themeController});

  @override
  Widget build(BuildContext context) {
    themeController.loadTheme();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Learning App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
     initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
    );
  }
}
