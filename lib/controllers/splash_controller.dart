import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _initializeApp();
  }

  void _initializeApp() async {
    await Future.delayed(const Duration(seconds: 3)); // Simulated initialization
    // Add your initialization logic here (e.g., check auth status, load initial data)
    Get.offAllNamed('/login');
  }
}
