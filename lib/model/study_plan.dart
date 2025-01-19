class StudyPlan {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String courseId;
  final String courseName;
  final bool isCompleted;
  final PlanType type;
  final String description;
  final bool hasReminder;

  StudyPlan({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.courseId,
    required this.courseName,
    this.isCompleted = false,
    required this.type,
    this.description = '',
    this.hasReminder = false,
  });
}

enum PlanType {
  studySession,
  deadline,
  milestone,
  quiz,
}