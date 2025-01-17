import 'package:e_learning/utils/app_routes.dart';
import 'package:get/get.dart';
import 'package:e_learning/view/splash page/splash_page.dart';
import 'package:e_learning/view/auth pages/pages/login_page.dart';
import 'package:e_learning/view/auth pages/pages/registeration_page.dart';
import 'package:e_learning/view/auth pages/pages/forgot_password_page.dart';
import 'package:e_learning/view/auth pages/pages/profile_setup_page.dart';
import 'package:e_learning/view/home page/pages/home_page.dart';
import 'package:e_learning/view/course related pages/pages/course_details_page.dart';
import 'package:e_learning/view/course related pages/pages/course_player_page.dart';
import 'package:e_learning/view/course related pages/pages/course_discussion_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterationPage(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => ForgotPasswordPage(),
    ),
    GetPage(
      name: AppRoutes.profileSetup,
      page: () => ProfileSetupPage(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: AppRoutes.courseDetails,
      page: () => CourseDetailsPage(
        course: Get.arguments['course'],
      ),
    ),
    GetPage(
      name: AppRoutes.coursePlayer,
      page: () => const CoursePlayerPage(),
    ),
    GetPage(
      name: AppRoutes.courseDiscussion,
      page: () => const CourseDiscussionPage(),
    ),
  ];
}
