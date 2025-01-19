import 'package:e_learning/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:e_learning/model/study_group.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';

class StudyGroupPage extends StatelessWidget {
  final StudyGroup group;

  const StudyGroupPage({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(group.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildGroupInfo(context),
          const SizedBox(height: 24),
          _buildDiscussionsSection(context),
          const SizedBox(height: 24),
          _buildProjectsSection(context),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDiscussionDialog(context),
        label: const Text('New Discussion'),
        icon: const Icon(Icons.add_comment),
      ),
    );
  }

    Widget _buildGroupInfo(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 30,
                child: Icon(Icons.group, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Course: ${group.courseName}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      group.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Members: ${group.memberIds.length}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDiscussionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Discussions',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: group.discussions.length,
          itemBuilder: (context, index) {
            final discussion = group.discussions[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                onTap: () => Get.toNamed(
                  AppRoutes.groupDiscussion,
                  arguments: {
                    'discussion': discussion,
                    'group': group,
                  },
                ),
                title: Text(discussion.title),
                subtitle: Text(
                  '${discussion.comments.length} comments • ${timeago.format(discussion.createdAt)}',
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildProjectsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Projects',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: group.projects.length,
          itemBuilder: (context, index) {
            final project = group.projects[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(project.title),
                subtitle: Text(
                  'Due: ${DateFormat('MMM dd, yyyy').format(project.deadline)}',
                ),
                trailing: _buildProjectStatusChip(project.status),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildProjectStatusChip(ProjectStatus status) {
    Color color;
    String label;

    switch (status) {
      case ProjectStatus.pending:
        color = Colors.grey;
        label = 'Pending';
        break;
      case ProjectStatus.ongoing:
        color = Colors.blue;
        label = 'Ongoing';
        break;
      case ProjectStatus.completed:
        color = Colors.green;
        label = 'Completed';
        break;
    }

    return Chip(
      label: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
    );
  }

  void _showAddDiscussionDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String title = '';
    String content = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Start New Discussion'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter discussion title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) => title = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Content',
                  hintText: 'Enter discussion content',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
                onSaved: (value) => content = value!,
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
                // TODO: Add discussion to the group
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
  // ... (let me know if you want to see the implementation of the other methods)