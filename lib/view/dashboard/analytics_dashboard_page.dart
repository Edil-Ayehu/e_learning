import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:e_learning/model/analytics_data.dart';
import 'package:e_learning/utils/app_colors.dart';

class AnalyticsDashboardPage extends StatelessWidget {
  final AnalyticsData analyticsData;

  const AnalyticsDashboardPage({
    super.key,
    required this.analyticsData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Analytics'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverallProgress(context),
            const SizedBox(height: 24),
            _buildTimeSpentAnalysis(context),
            const SizedBox(height: 24),
            _buildLearningStreak(context),
            const SizedBox(height: 24),
            _buildSkillsProgress(context),
            const SizedBox(height: 24),
            _buildAchievements(context),
          ],
        ),
      ),
    );
  }

  // ... existing code ...

  Widget _buildLearningStreak(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Learning Streak',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${analyticsData.learningStreak} days',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7, // Show last 7 days
                itemBuilder: (context, index) {
                  final date = DateTime.now().subtract(Duration(days: 6 - index));
                  final dailyData = analyticsData.dailyStudyData
                      .firstWhere(
                        (data) =>
                            data.date.year == date.year &&
                            data.date.month == date.month &&
                            data.date.day == date.day,
                        orElse: () => DailyStudyData(
                          date: date,
                          timeSpent: 0,
                          lessonsCompleted: 0,
                        ),
                      );

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Container(
                          width: 40,
                          height: 60,
                          decoration: BoxDecoration(
                            color: dailyData.timeSpent > 0
                                ? AppColors.primaryColor
                                : AppColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              '${dailyData.timeSpent}m',
                              style: TextStyle(
                                color: dailyData.timeSpent > 0
                                    ? Colors.white
                                    : AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _getWeekdayLabel(date.weekday),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getWeekdayLabel(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }

// ... existing code ...

  Widget _buildOverallProgress(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overall Progress',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: analyticsData.dailyStudyData
                          .map((data) => FlSpot(
                                data.date.millisecondsSinceEpoch.toDouble(),
                                data.timeSpent.toDouble(),
                              ))
                          .toList(),
                      isCurved: true,
                      color: AppColors.primaryColor,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSpentAnalysis(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Time Spent per Course',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: analyticsData.timePerCourse.entries
                      .map(
                        (entry) => PieChartSectionData(
                          value: entry.value.toDouble(),
                          title: '${entry.key}\n${entry.value}h',
                          radius: 100,
                          titleStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsProgress(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Skills Progress',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ...analyticsData.skillProgress.entries.map(
              (entry) => Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(entry.key),
                      ),
                      Text('${(entry.value * 100).toInt()}%'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: entry.value,
                    backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievements(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Achievements',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: analyticsData.achievements.length,
              itemBuilder: (context, index) {
                final achievement = analyticsData.achievements[index];
                return _buildAchievementCard(context, achievement);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementCard(BuildContext context, Achievement achievement) {
    return Card(
      color: AppColors.primaryColor.withOpacity(0.1),
      child: Tooltip(
        message: achievement.description,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              achievement.icon,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 8),
            Text(
              achievement.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
