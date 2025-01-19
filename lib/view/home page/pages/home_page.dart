import 'package:e_learning/controllers/theme_controller.dart';
import 'package:e_learning/model/analytics_data.dart';
import 'package:e_learning/model/course.dart';
import 'package:e_learning/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Learning',
            style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          IconButton(
            icon: const Icon(Icons.group),
            onPressed: () => Get.toNamed(AppRoutes.peerLearning),
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => Get.toNamed(AppRoutes.studyPlanner),
          ),
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: () => _navigateToAnalytics(),
          ),
          GetBuilder<ThemeController>(
            builder: (controller) => IconButton(
              icon: Icon(
                  controller.isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: controller.changeTheme,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeSection(context),
            const SizedBox(height: 24),
            _buildOngoingCoursesSection(context),
            const SizedBox(height: 24),
            _buildCategoriesSection(context),
            const SizedBox(height: 24),
            _buildFeaturedCoursesSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back!',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        const SizedBox(height: 8),
        Text(
          'What would you like to learn today?',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildOngoingCoursesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Continue Learning',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: ongoingCourses.length,
            itemBuilder: (context, index) {
              final course = ongoingCourses[index];
              return _buildCourseCard(context, course);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _buildCategoryCard(context, category);
          },
        ),
      ],
    );
  }

  Widget _buildFeaturedCoursesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured Courses',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: featuredCourses.length,
          itemBuilder: (context, index) {
            final course = featuredCourses[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildFeaturedCourseCard(context, course),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCourseCard(BuildContext context, Course course) {
    return Card(
      margin: const EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: () => Get.toNamed(
          AppRoutes.courseDetails,
          arguments: {'course': course},
        ),
        child: Container(
          width: 280,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  course.imageUrl,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                course.title,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                course.instructor,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const Spacer(),
              LinearProgressIndicator(value: course.progress),
              const SizedBox(height: 4),
              Text(
                '${(course.progress * 100).toInt()}% Complete',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, Category category) {
    return Card(
      child: InkWell(
        onTap: () => Get.toNamed(
          AppRoutes.categoryListing,
          arguments: {'category': category},
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                category.icon,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 8),
              Text(
                category.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '${category.courseCount} Courses',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedCourseCard(BuildContext context, Course course) {
    return Card(
      child: InkWell(
        onTap: () =>
            Get.toNamed(AppRoutes.courseDetails, arguments: {'course': course}),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  course.imageUrl,
                  height: 80,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      course.instructor,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      course.duration,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToAnalytics() {
    // Create sample analytics data (replace with real data from your backend)
    final analyticsData = AnalyticsData(
      overallProgress: 0.65,
      totalTimeSpent: 480, // 8 hours
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

    Get.toNamed(
      AppRoutes.analytics,
      arguments: {'analyticsData': analyticsData},
    );
  }
}
