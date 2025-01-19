import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_learning/utils/app_routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(context),
            _buildProfileStats(context),
            _buildProfileMenu(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://picsum.photos/200'),
          ),
          const SizedBox(height: 16),
          Text(
            'John Doe',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            'john.doe@example.com',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStats(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(context, '12', 'Courses\nCompleted'),
          _buildStatItem(context, '48', 'Hours\nLearned'),
          _buildStatItem(context, '4.8', 'Average\nRating'),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildProfileMenu(BuildContext context) {
    return Column(
      children: [
        _buildMenuItem(
          context,
          Icons.person_outline,
          'Edit Profile',
          () => Get.toNamed(AppRoutes.profileSetup),
        ),
        _buildMenuItem(
          context,
          Icons.school_outlined,
          'Certificates',
          () {},
        ),
        _buildMenuItem(
          context,
          Icons.notifications_outlined,
          'Notifications',
          () {},
        ),
        _buildMenuItem(
          context,
          Icons.settings_outlined,
          'Settings',
          () {},
        ),
        _buildMenuItem(
          context,
          Icons.help_outline,
          'Help & Support',
          () {},
        ),
        _buildMenuItem(
          context,
          Icons.logout,
          'Logout',
          () => Get.offAllNamed(AppRoutes.login),
          isDestructive: true,
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive
            ? Theme.of(context).colorScheme.error
            : Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: isDestructive
                  ? Theme.of(context).colorScheme.error
                  : null,
            ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
