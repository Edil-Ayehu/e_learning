import 'package:get/get.dart';
import 'package:e_learning/model/study_group.dart';

class PeerLearningController extends GetxController {
  final List<StudyGroup> myGroups = [];
  final List<StudyGroup> availableGroups = [];

  @override
  void onInit() {
    super.onInit();
    loadGroups();
  }

  Future<void> loadGroups() async {
    // TODO: Load from backend
    // For now, adding sample data
    final sampleGroup = StudyGroup(
      id: '1',
      name: 'Flutter Study Group',
      description: 'A group for learning Flutter development',
      courseId: '1',
      courseName: 'Flutter Development',
      creatorId: 'user1',
      createdAt: DateTime.now(),
    );

    myGroups.add(sampleGroup);
    
    final availableGroup = StudyGroup(
      id: '2',
      name: 'Dart Programming',
      description: 'Learn Dart programming language',
      courseId: '2',
      courseName: 'Dart Basics',
      creatorId: 'user2',
      createdAt: DateTime.now(),
    );

    availableGroups.add(availableGroup);
    update();
  }

  Future<void> createGroup(StudyGroup group) async {
    // TODO: Send to backend
    myGroups.add(group);
    update();
  }

  Future<void> joinGroup(StudyGroup group) async {
    // TODO: Send to backend
    availableGroups.remove(group);
    myGroups.add(group);
    update();
  }

  Future<void> leaveGroup(StudyGroup group) async {
    // TODO: Send to backend
    myGroups.remove(group);
    availableGroups.add(group);
    update();
  }
}
