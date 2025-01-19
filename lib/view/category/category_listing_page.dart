import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_learning/model/course.dart';
import 'package:e_learning/utils/app_routes.dart';

class CategoryListingPage extends StatelessWidget {
  final Category category;

  const CategoryListingPage({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryHeader(context),
            const SizedBox(height: 24),
            _buildCoursesList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              category.icon,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  '${category.courseCount} Courses',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCoursesList(BuildContext context) {
    // Filter courses based on category
    final categoryCourses = [...featuredCourses, ...ongoingCourses]
        .where((course) => _courseMatchesCategory(course, category.name))
        .toList();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categoryCourses.length,
      itemBuilder: (context, index) {
        final course = categoryCourses[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () => Get.toNamed(
              AppRoutes.courseDetails,
              arguments: {'course': course},
            ),
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
      },
    );
  }

  bool _courseMatchesCategory(Course course, String categoryName) {
    // This is a simple implementation. In a real app, you would have a proper
    // category field in the Course model
    switch (categoryName) {
      case 'Development':
        return course.title.toLowerCase().contains('flutter') ||
            course.title.toLowerCase().contains('development');
      case 'Design':
        return course.title.toLowerCase().contains('design') ||
            course.title.toLowerCase().contains('ui');
      case 'Business':
        return course.title.toLowerCase().contains('business');
      case 'Marketing':
        return course.title.toLowerCase().contains('marketing');
      default:
        return false;
    }
  }
}
