import 'package:e_learning/model/comment.dart';
import 'package:flutter/material.dart';
import 'package:e_learning/model/study_group.dart';
import 'package:timeago/timeago.dart' as timeago;

class GroupDiscussionPage extends StatelessWidget {
  final Discussion discussion;
  final StudyGroup group;

  const GroupDiscussionPage({
    Key? key,
    required this.discussion,
    required this.group,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(discussion.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: discussion.comments.length,
              itemBuilder: (context, index) {
                return _buildCommentCard(context, discussion.comments[index]);
              },
            ),
          ),
          _buildCommentInput(context),
        ],
      ),
    );
  }

    Widget _buildCommentCard(BuildContext context, Comment comment) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(comment.authorName[0]),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.authorName,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        timeago.format(comment.createdAt),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(comment.content),
            if (comment.replies.isNotEmpty) ...[
              const SizedBox(height: 8),
              const Divider(),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: comment.replies.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: _buildCommentCard(context, comment.replies[index]),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCommentInput(BuildContext context) {
    final textController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: 'Write a comment...',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              final content = textController.text.trim();
              if (content.isNotEmpty) {
                // TODO: Add comment to the discussion
                textController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
  // ... (let me know if you want to see the implementation of the other methods)