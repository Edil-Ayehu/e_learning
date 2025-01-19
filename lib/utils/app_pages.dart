import 'package:e_learning/utils/app_routes.dart';
import 'package:e_learning/view/course%20related%20pages/pages/course_certificate_page.dart';
import 'package:e_learning/view/course%20related%20pages/pages/course_progress_page.dart';
import 'package:e_learning/view/course%20related%20pages/pages/course_quiz_page.dart';
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
import 'package:e_learning/model/course.dart';

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
      page: () => CoursePlayerPage(
        lessonIndex: Get.arguments['lessonIndex'] as int,
        course: Get.arguments['course'] as Course,
      ),
    ),
    GetPage(
      name: AppRoutes.courseDiscussion,
      page: () => CourseDiscussionPage(
        course: Get.arguments?['course'] as Course?,
      ),
    ),
    GetPage(
      name: AppRoutes.courseQuiz,
      page: () => CourseQuizPage(
        course: Get.arguments?['course'] as Course?,
      ),
    ),
    GetPage(
      name: AppRoutes.courseProgress,
      page: () => CourseProgressPage(
        course: Get.arguments?['course'] as Course?,
      ),
    ),
    GetPage(
      name: AppRoutes.courseCertificate,
      page: () => CourseCertificatePage(
        course: Get.arguments?['course'] as Course?,
      ),
    ),
  ];
}
