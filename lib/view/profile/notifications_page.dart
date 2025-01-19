import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: () => _markAllAsRead(),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _getNotifications().length,
        itemBuilder: (context, index) {
          final notification = _getNotifications()[index];
          return _buildNotificationTile(context, notification);
        },
      ),
    );
  }

  Widget _buildNotificationTile(BuildContext context, Notification notification) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        child: Icon(
          notification.icon,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(notification.title),
      subtitle: Text(notification.message),
      trailing: Text(
        notification.time,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      onTap: () => _handleNotificationTap(notification),
    );
  }

  List<Notification> _getNotifications() {
    return [
      Notification(
        title: 'New Course Available',
        message: 'Check out our new Flutter Advanced Course',
        time: '2h ago',
        icon: Icons.school,
      ),
      Notification(
        title: 'Achievement Unlocked',
        message: 'You completed 5 lessons today!',
        time: '5h ago',
        icon: Icons.emoji_events,
      ),
    ];
  }

  void _markAllAsRead() {
    // Implement mark all as read
  }

  void _handleNotificationTap(Notification notification) {
    // Handle notification tap
  }
}

class Notification {
  final String title;
  final String message;
  final String time;
  final IconData icon;

  Notification({
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
  });
}
