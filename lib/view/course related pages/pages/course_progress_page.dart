import 'package:e_learning/model/course.dart';
import 'package:flutter/material.dart';
import 'package:e_learning/utils/app_colors.dart';

class CourseProgressPage extends StatelessWidget {
  final Course? course;
  const CourseProgressPage({super.key, this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Progress'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverallProgress(context),
            const SizedBox(height: 24),
            _buildModuleProgress(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallProgress(BuildContext context) {
    // Get screen width to calculate responsive sizes
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360; // Breakpoint for small devices

    return Card(
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overall Progress',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            // Use LayoutBuilder to make content responsive
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 300) {
                  // For very small screens, stack the content vertically
                  return Column(
                    children: [
                      _buildProgressCircle(context),
                      const SizedBox(height: 16),
                      _buildProgressStats(context),
                    ],
                  );
                } else {
                  // For larger screens, keep the row layout
                  return Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: _buildProgressCircle(context),
                      ),
                      SizedBox(width: isSmallScreen ? 12 : 24),
                      Expanded(
                        flex: 3,
                        child: _buildProgressStats(context),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Extract progress circle to separate widget
  Widget _buildProgressCircle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final circleSize = screenWidth * 0.15; // Responsive circle size

    return Column(
      children: [
        SizedBox(
          height: circleSize,
          width: circleSize,
          child: const CircularProgressIndicator(
            value: 0.65,
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.primaryColor,
            ),
            strokeWidth: 8,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '65% Complete',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }

  // Extract progress stats to separate widget
  Widget _buildProgressStats(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProgressStat(context, 'Completed Lessons', '13/20'),
        const SizedBox(height: 8),
        _buildProgressStat(context, 'Time Spent', '8h 30m'),
        const SizedBox(height: 8),
        _buildProgressStat(context, 'Quiz Score', '85%'),
      ],
    );
  }

  // Update progress stat to handle overflow
  Widget _buildProgressStat(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildModuleProgress(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Modules Progress',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return _buildModuleCard(context, index);
          },
        ),
      ],
    );
  }

  Widget _buildModuleCard(BuildContext context, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text('Module ${index + 1}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: (index + 1) * 0.2,
              backgroundColor: Colors.grey[300],
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
            ),
            const SizedBox(height: 4),
            Text('${((index + 1) * 20)}% Complete'),
          ],
        ),
      ),
    );
  }
}
