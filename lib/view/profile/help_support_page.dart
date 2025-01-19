import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSearchBar(context),
          const SizedBox(height: 24),
          _buildSection(
            context,
            'Frequently Asked Questions',
            [
              _buildFaqTile(
                context,
                'How do I reset my password?',
                'To reset your password, go to the login screen and tap on "Forgot Password"...',
              ),
              _buildFaqTile(
                context,
                'How do I download courses for offline viewing?',
                'You can download courses by tapping the download icon on the course page...',
              ),
              _buildFaqTile(
                context,
                'How do I get a course certificate?',
                'Complete all course modules and pass the final assessment to receive your certificate...',
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            'Contact Us',
            [
              _buildContactTile(
                context,
                'Email Support',
                'support@elearning.com',
                Icons.email_outlined,
                () => _launchEmail('support@elearning.com'),
              ),
              _buildContactTile(
                context,
                'Live Chat',
                'Chat with our support team',
                Icons.chat_outlined,
                () => _openLiveChat(),
              ),
              _buildContactTile(
                context,
                'Call Us',
                '+1 (555) 123-4567',
                Icons.phone_outlined,
                () => _launchPhone('+15551234567'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildHelpButton(context),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search help articles...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildFaqTile(BuildContext context, String question, String answer) {
    return ExpansionTile(
      title: Text(question),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            answer,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildContactTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildHelpButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _openHelpCenter(),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text('Visit Help Center'),
    );
  }

  void _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  void _launchPhone(String phone) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  void _openLiveChat() {
    // Implement live chat functionality
  }

  void _openHelpCenter() {
    // Implement help center navigation
  }
}
