import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_learning/utils/auth_styles.dart';
import 'package:e_learning/utils/app_colors.dart';

class ProfileSetupPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  
  ProfileSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthStyles.buildAuthScaffold(
      context,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Complete Your Profile',
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Help us personalize your learning experience',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primaryLightColor,
                child: const Icon(Icons.person_outline, size: 50),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt, size: 18),
                    onPressed: () {
                      // Handle image upload
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: AuthStyles.textFieldDecoration(
                    'Bio',
                    Icons.edit_outlined,
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: AuthStyles.textFieldDecoration(
                    'Interests',
                    Icons.interests_outlined,
                  ),
                  items: ['Development', 'Design', 'Business', 'Marketing']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: AuthStyles.primaryButtonStyle,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Get.offAllNamed('/home');
                    }
                  },
                  child: const Text('Complete Setup'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
