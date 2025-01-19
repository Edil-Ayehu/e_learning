import 'package:e_learning/model/comment.dart';

class StudyGroup {
  final String id;
  final String name;
  final String description;
  final String courseId;
  final String courseName;
  final String creatorId;
  final List<String> memberIds;
  final List<String> mentorIds;
  final List<Discussion> discussions;
  final List<Project> projects;
  final DateTime createdAt;

  StudyGroup({
    required this.id,
    required this.name,
    required this.description,
    required this.courseId,
    required this.courseName,
    required this.creatorId,
    this.memberIds = const [],
    this.mentorIds = const [],
    this.discussions = const [],
    this.projects = const [],
    required this.createdAt,
  });
}

class Discussion {
  final String id;
  final String title;
  final String content;
  final String authorId;
  final DateTime createdAt;
  final List<Comment> comments;

  Discussion({
    required this.id,
    required this.title,
    required this.content,
    required this.authorId,
    required this.createdAt,
    this.comments = const [],
  });
}

class Project {
  final String id;
  final String title;
  final String description;
  final DateTime deadline;
  final List<String> assignedMembers;
  final ProjectStatus status;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.deadline,
    required this.assignedMembers,
    this.status = ProjectStatus.ongoing,
  });
}

enum ProjectStatus { pending, ongoing, completed }