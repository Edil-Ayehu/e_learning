import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_learning/controllers/theme_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _buildSection(
            context,
            'Account',
            [
              _buildSettingTile(
                context,
                'Email Notifications',
                subtitle: 'Manage email preferences',
                trailing: Switch(
                  value: true,
                  onChanged: (value) {},
                ),
              ),
              _buildSettingTile(
                context,
                'Push Notifications',
                subtitle: 'Manage push notifications',
                trailing: Switch(
                  value: true,
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          _buildSection(
            context,
            'Appearance',
            [
              GetBuilder<ThemeController>(
                builder: (controller) => _buildSettingTile(
                  context,
                  'Dark Mode',
                  subtitle: 'Toggle dark/light theme',
                  trailing: Switch(
                    value: controller.isDarkMode,
                    onChanged: (value) => controller.changeTheme(),
                  ),
                ),
              ),
              _buildSettingTile(
                context,
                'Text Size',
                subtitle: 'Adjust app text size',
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showTextSizeDialog(context),
              ),
            ],
          ),
          _buildSection(
            context,
            'Learning Preferences',
            [
              _buildSettingTile(
                context,
                'Download Quality',
                subtitle: 'Video quality for downloads',
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showQualityDialog(context),
              ),
              _buildSettingTile(
                context,
                'Autoplay Videos',
                subtitle: 'Play next video automatically',
                trailing: Switch(
                  value: true,
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          _buildSection(
            context,
            'Privacy & Security',
            [
              _buildSettingTile(
                context,
                'Privacy Settings',
                subtitle: 'Manage your data and privacy',
                onTap: () {},
              ),
              _buildSettingTile(
                context,
                'Change Password',
                subtitle: 'Update your password',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> tiles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ...tiles,
      ],
    );
  }

  Widget _buildSettingTile(
    BuildContext context,
    String title, {
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: trailing,
      onTap: onTap,
    );
  }

  void _showTextSizeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Text Size'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: const Text('Small'),
              value: 'small',
              groupValue: 'medium',
              onChanged: (value) => Navigator.pop(context),
            ),
            RadioListTile(
              title: const Text('Medium'),
              value: 'medium',
              groupValue: 'medium',
              onChanged: (value) => Navigator.pop(context),
            ),
            RadioListTile(
              title: const Text('Large'),
              value: 'large',
              groupValue: 'medium',
              onChanged: (value) => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showQualityDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Download Quality'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: const Text('Auto'),
              value: 'auto',
              groupValue: 'auto',
              onChanged: (value) => Navigator.pop(context),
            ),
            RadioListTile(
              title: const Text('High'),
              value: 'high',
              groupValue: 'auto',
              onChanged: (value) => Navigator.pop(context),
            ),
            RadioListTile(
              title: const Text('Medium'),
              value: 'medium',
              groupValue: 'auto',
              onChanged: (value) => Navigator.pop(context),
            ),
            RadioListTile(
              title: const Text('Low'),
              value: 'low',
              groupValue: 'auto',
              onChanged: (value) => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
