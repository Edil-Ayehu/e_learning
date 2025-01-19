class AnalyticsData {
  final double overallProgress;
  final int totalTimeSpent; // in minutes
  final Map<String, int> timePerCourse;
  final List<Achievement> achievements;
  final Map<String, double> skillProgress;
  final int learningStreak;
  final List<DailyStudyData> dailyStudyData;

  AnalyticsData({
    required this.overallProgress,
    required this.totalTimeSpent,
    required this.timePerCourse,
    required this.achievements,
    required this.skillProgress,
    required this.learningStreak,
    required this.dailyStudyData,
  });
}

class Achievement {
  final String title;
  final String description;
  final String icon;
  final DateTime dateEarned;

  Achievement({
    required this.title,
    required this.description,
    required this.icon,
    required this.dateEarned,
  });
}

class DailyStudyData {
  final DateTime date;
  final int timeSpent;
  final int lessonsCompleted;

  DailyStudyData({
    required this.date,
    required this.timeSpent,
    required this.lessonsCompleted,
  });
}
