import 'package:e_learning/controllers/theme_controller.dart';
import 'package:e_learning/model/course.dart';
import 'package:e_learning/utils/app_colors.dart';
import 'package:e_learning/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWelcomeSection(),
                    const SizedBox(height: 24),
                    _buildFeaturedCourses(),
                    const SizedBox(height: 24),
                    _buildCategories(),
                    const SizedBox(height: 24),
                    _buildOngoingCourses(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      floating: true,
      title: Text('E-Learning', style: AppTextStyles.h2),
      actions: [
        IconButton(
          icon: GetBuilder<ThemeController>(
            builder: (controller) => Icon(
              controller.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
          onPressed: () => themeController.toggleTheme(),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Welcome back,', style: AppTextStyles.h3),
        Text('Continue Learning!', style: AppTextStyles.h1),
      ],
    );
  }

  Widget _buildFeaturedCourses() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Featured Courses', style: AppTextStyles.h3),
        const SizedBox(height: 16),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: featuredCourses.length,
            itemBuilder: (context, index) {
              final course = featuredCourses[index];
              return _buildFeaturedCourseCard(course);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedCourseCard(Course course) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Get.isDarkMode ? AppColors.surfaceDarkColor : AppColors.surfaceColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              course.imageUrl,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(course.title, style: AppTextStyles.subtitle1),
                const SizedBox(height: 8),
                Text(course.instructor, style: AppTextStyles.body2),
                const SizedBox(height: 8),
                Text(course.duration, style: AppTextStyles.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Categories', style: AppTextStyles.h3),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _buildCategoryCard(category);
          },
        ),
      ],
    );
  }

  Widget _buildCategoryCard(Category category) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Get.isDarkMode ? AppColors.surfaceDarkColor : AppColors.surfaceColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(category.icon, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            Text(category.name, style: AppTextStyles.subtitle2),
            Text('${category.courseCount} Courses', style: AppTextStyles.caption),
          ],
        ),
      ),
    );
  }

  Widget _buildOngoingCourses() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ongoing Courses', style: AppTextStyles.h3),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: ongoingCourses.length,
          itemBuilder: (context, index) {
            final course = ongoingCourses[index];
            return _buildOngoingCourseCard(course);
          },
        ),
      ],
    );
  }

  Widget _buildOngoingCourseCard(Course course) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Get.isDarkMode ? AppColors.surfaceDarkColor : AppColors.surfaceColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                course.imageUrl,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(course.title, style: AppTextStyles.subtitle1),
                  const SizedBox(height: 4),
                  Text(course.instructor, style: AppTextStyles.body2),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: course.progress,
                    backgroundColor: AppColors.primaryLightColor.withOpacity(0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                  ),
                  const SizedBox(height: 4),
                  Text('${(course.progress * 100).toInt()}% Complete',
                      style: AppTextStyles.caption),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
