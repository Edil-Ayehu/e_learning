import 'package:e_learning/controllers/peer_learning_controller.dart';
import 'package:e_learning/model/study_group.dart';
import 'package:e_learning/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PeerLearningHub extends StatelessWidget {
  final peerLearningController = Get.put(PeerLearningController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peer Learning Hub'),
      ),
      body: GetBuilder<PeerLearningController>(
        builder: (controller) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildCreateGroupButton(context),
            const SizedBox(height: 24),
            _buildMyGroupsSection(context),
            const SizedBox(height: 24),
            _buildAvailableGroupsSection(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateGroupDialog(context),
        label: const Text('Create Study Group'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildMyGroupsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Study Groups',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: peerLearningController.myGroups.length,
          itemBuilder: (context, index) {
            final group = peerLearningController.myGroups[index];
            return _buildGroupCard(context, group);
          },
        ),
      ],
    );
  }

    Widget _buildCreateGroupButton(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => _showCreateGroupDialog(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.group_add, size: 32),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create a Study Group',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'Start collaborating with peers',
                      style: Theme.of(context).textTheme.bodyMedium,
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

  Widget _buildAvailableGroupsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available Groups',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: peerLearningController.availableGroups.length,
          itemBuilder: (context, index) {
            final group = peerLearningController.availableGroups[index];
            return _buildGroupCard(context, group);
          },
        ),
      ],
    );
  }

  Widget _buildGroupCard(BuildContext context, StudyGroup group) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: () => Get.toNamed(
          AppRoutes.studyGroup,
          arguments: {'group': group},
        ),
        title: Text(group.name),
        subtitle: Text(group.courseName),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () => Get.toNamed(
            AppRoutes.studyGroup,
            arguments: {'group': group},
          ),
        ),
      ),
    );
  }
    void _showCreateGroupDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String name = '';
    String description = '';
    String courseName = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Study Group'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Group Name',
                  hintText: 'Enter group name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a group name';
                  }
                  return null;
                },
                onSaved: (value) => name = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter group description',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) => description = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Course Name',
                  hintText: 'Enter associated course name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a course name';
                  }
                  return null;
                },
                onSaved: (value) => courseName = value!,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                formKey.currentState?.save();
                
                final newGroup = StudyGroup(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: name,
                  description: description,
                  courseId: '1', // TODO: Replace with actual course ID
                  courseName: courseName,
                  creatorId: 'currentUserId', // TODO: Replace with actual user ID
                  createdAt: DateTime.now(),
                );
                
                peerLearningController.createGroup(newGroup);
                Navigator.pop(context);
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
