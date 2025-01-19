import 'package:e_learning/utils/app_routes.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final RxBool isLoading = false.obs;

  Future<void> login() async {
    try {
      isLoading.value = true;
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      Get.offAllNamed(AppRoutes.main);
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }
}
