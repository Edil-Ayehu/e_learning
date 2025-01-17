import 'package:e_learning/controllers/theme_controller.dart';
import 'package:e_learning/utils/app_theme.dart';
import 'package:e_learning/view/auth%20pages/pages/forgot_password_page.dart';
import 'package:e_learning/view/auth%20pages/pages/login_page.dart';
import 'package:e_learning/view/auth%20pages/pages/profile_setup_page.dart';
import 'package:e_learning/view/auth%20pages/pages/registeration_page.dart';
import 'package:e_learning/view/home%20page/pages/home_page.dart';
import 'package:e_learning/view/splash%20page/splash_page.dart';
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
      title: 'E-Learning App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
     initialRoute: '/splash',
      getPages: [
         GetPage(name: '/splash', page: () => const SplashPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/forgot-password', page: () => ForgotPasswordPage()),
        GetPage(name: '/profile-setup', page: () => ProfileSetupPage()),
        GetPage(name: '/home', page: () => const HomePage()),
      ],
    );
  }
}
