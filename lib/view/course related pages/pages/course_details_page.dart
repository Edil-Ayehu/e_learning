import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_learning/utils/app_colors.dart';
import 'package:e_learning/model/course.dart';
import 'package:e_learning/utils/app_routes.dart';

class CourseDetailsPage extends StatelessWidget {
  final Course course;

  const CourseDetailsPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCourseInfo(context),
                  const SizedBox(height: 24),
                  _buildInstructorInfo(context),
                  const SizedBox(height: 24),
                  _buildCourseContent(context),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildEnrollButton(context),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          course.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCourseInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          course.title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.person_outline,
                color: AppColors.textSecondaryColor),
            const SizedBox(width: 8),
            Text(course.instructor),
            const Spacer(),
            const Icon(Icons.timer_outlined,
                color: AppColors.textSecondaryColor),
            const SizedBox(width: 8),
            Text(course.duration),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(
                Icons.forum_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () => Get.toNamed(
                AppRoutes.courseDiscussion,
                arguments: {'course': course},
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.quiz_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () => Get.toNamed(
                AppRoutes.courseQuiz,
                arguments: {'course': course},
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.bar_chart,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () => Get.toNamed(
                AppRoutes.courseProgress,
                arguments: {'course': course},
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.workspace_premium_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () => Get.toNamed(
                AppRoutes.courseCertificate,
                arguments: {'course': course},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInstructorInfo(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage('instructor_image_url'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.instructor,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    'Expert Instructor',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondaryColor,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Course Content',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5, // Replace with actual content count
          itemBuilder: (context, index) {
            return _buildContentItem(context, index);
          },
        ),
      ],
    );
  }

  Widget _buildContentItem(BuildContext context, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.play_circle_outline,
            color: AppColors.primaryColor),
        title: Text('Lesson ${index + 1}'),
        subtitle: const Text('Duration: 15 mins'),
        trailing:
            const Icon(Icons.lock_outline, color: AppColors.textSecondaryColor),
        onTap: () {
          Get.toNamed(
            AppRoutes.coursePlayer,
            arguments: {
              'lessonIndex': index,
              'course': course, // Pass the course data to player
            },
          );
        },
      ),
    );
  }

  Widget _buildEnrollButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          Get.toNamed(
            AppRoutes.courseProgress,
            arguments: {'course': course},
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text(
          'Enroll Now',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
