import 'package:e_learning/model/analytics_data.dart';
import 'package:e_learning/view/home%20page/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_learning/controllers/theme_controller.dart';
import 'package:e_learning/view/dashboard/study_planner_page.dart';
import 'package:e_learning/view/peer%20leanrning%20hub/peer_learning_hub_page.dart';
import 'package:e_learning/view/dashboard/analytics_dashboard_page.dart';
import 'package:e_learning/view/profile/profile_page.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  
  // Move selectedIndex outside build method and make it static
  static final RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Learning',
            style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          GetBuilder<ThemeController>(
            builder: (controller) => IconButton(
              icon: Icon(
                  controller.isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: controller.changeTheme,
            ),
          ),
        ],
      ),
      body: Obx(() => IndexedStack(
            index: selectedIndex.value,
            children: [
              const HomePage(),
              StudyPlannerPage(),
              PeerLearningHub(),
              AnalyticsDashboardPage(
                analyticsData: _getAnalyticsData(),
              ),
              ProfilePage(),
            ],
          )),
      bottomNavigationBar: Obx(() => NavigationBar(
            selectedIndex: selectedIndex.value,
            onDestinationSelected: (index) => selectedIndex.value = index,
            backgroundColor: Theme.of(context).colorScheme.surface,
            indicatorColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.2),
            destinations: _buildNavigationDestinations(context, selectedIndex.value),
          )),
    );
  }

  List<NavigationDestination> _buildNavigationDestinations(
      BuildContext context, int selectedIndex) {
    return [
      _buildNavigationDestination(
        context,
        icon: CupertinoIcons.home,
        label: 'Home',
        index: 0,
        selectedIndex: selectedIndex,
      ),
      _buildNavigationDestination(
        context,
        icon: CupertinoIcons.calendar,
        label: 'Planner',
        index: 1,
        selectedIndex: selectedIndex,
      ),
      _buildNavigationDestination(
        context,
        icon: CupertinoIcons.person_2,
        label: 'Peers',
        index: 2,
        selectedIndex: selectedIndex,
      ),
      _buildNavigationDestination(
        context,
        icon: CupertinoIcons.chart_bar,
        label: 'Analytics',
        index: 3,
        selectedIndex: selectedIndex,
      ),
      _buildNavigationDestination(
        context,
        icon: CupertinoIcons.person,
        label: 'Profile',
        index: 4,
        selectedIndex: selectedIndex,
      ),
    ];
  }

  NavigationDestination _buildNavigationDestination(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int index,
    required int selectedIndex,
  }) {
    return NavigationDestination(
      icon: Icon(
        icon,
        color: selectedIndex == index
            ? Theme.of(context).colorScheme.primary
            : null,
      ),
      selectedIcon: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
      label: label,
    );
  }

    AnalyticsData _getAnalyticsData() {
    return AnalyticsData(
      overallProgress: 0.65,
      totalTimeSpent: 480,
      timePerCourse: {
        'Flutter Development': 180,
        'Dart Basics': 120,
        'UI Design': 180,
      },
      achievements: [
        Achievement(
          title: 'Fast Learner',
          description: 'Completed 5 lessons in one day',
          icon: '🚀',
          dateEarned: DateTime.now(),
        ),
        Achievement(
          title: 'Streak Master',
          description: 'Maintained a 7-day learning streak',
          icon: '🔥',
          dateEarned: DateTime.now(),
        ),
      ],
      skillProgress: {
        'Flutter': 0.8,
        'Dart': 0.7,
        'UI/UX': 0.6,
      },
      learningStreak: 7,
      dailyStudyData: List.generate(
        7,
        (index) => DailyStudyData(
          date: DateTime.now().subtract(Duration(days: 6 - index)),
          timeSpent: 60 + (index * 10),
          lessonsCompleted: 2 + index,
        ),
      ),
    );
  }
}
