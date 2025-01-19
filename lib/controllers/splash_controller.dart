import 'package:get/get.dart';
import 'package:e_learning/utils/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _initializeApp();
  }

  void _initializeApp() async {
    await Future.delayed(const Duration(seconds: 3)); // Simulated initialization
    // Add your initialization logic here (e.g., check auth status, load initial data)
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    // Replace this with your actual authentication check
    bool isLoggedIn = false;
    
    if (isLoggedIn) {
      Get.offAllNamed(AppRoutes.main);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
