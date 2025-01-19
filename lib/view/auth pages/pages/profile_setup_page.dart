import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_learning/utils/app_colors.dart';
import 'package:e_learning/common/widgets/custom_button.dart';

class ProfileSetupPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final RxList<String> selectedInterests = <String>[].obs;

  ProfileSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.05),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 32),
                  _buildProfileForm(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primaryColor,
                    AppColors.primaryColor.withOpacity(0.8),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.person_outline,
                size: 60,
                color: Colors.white,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.camera_alt,
                    size: 20,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () {
                    // Handle image upload
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'Complete Your Profile',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Help us personalize your learning experience',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondaryColor,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildProfileForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildInputField(
            context,
            label: 'Full Name',
            icon: Icons.person_outline,
            validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter your name' : null,
          ),
          const SizedBox(height: 16),
          _buildInputField(
            context,
            label: 'Username',
            icon: Icons.alternate_email,
            validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter a username' : null,
          ),
          const SizedBox(height: 16),
          _buildInputField(
            context,
            label: 'Bio',
            icon: Icons.edit_outlined,
            maxLines: 3,
            validator: (value) =>
                value?.isEmpty ?? true ? 'Please tell us about yourself' : null,
          ),
          const SizedBox(height: 16),
          _buildEducationField(context),
          const SizedBox(height: 16),
          _buildInterestsField(context),
          const SizedBox(height: 16),
          _buildExperienceLevel(context),
          const SizedBox(height: 16),
          _buildLearningGoals(context),
          const SizedBox(height: 32),
          CustomButton(
            text: 'Complete Setup',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Get.offAllNamed('/home');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(
    BuildContext context, {
    required String label,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppColors.primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Theme.of(context).cardColor,
          labelStyle: TextStyle(color: AppColors.textSecondaryColor),
          floatingLabelStyle: TextStyle(color: AppColors.primaryColor),
        ),
        maxLines: maxLines,
        validator: validator,
      ),
    );
  }

  Widget _buildEducationField(BuildContext context) {
    final educationLevels = [
      'High School',
      'Bachelor\'s Degree',
      'Master\'s Degree',
      'Ph.D.',
      'Self-Taught',
      'Other'
    ];

    return _buildDropdownField(
      context,
      label: 'Education Level',
      icon: Icons.school_outlined,
      items: educationLevels,
      validator: (value) =>
          value == null ? 'Please select your education level' : null,
    );
  }

  Widget _buildExperienceLevel(BuildContext context) {
    final levels = ['Beginner', 'Intermediate', 'Advanced', 'Expert'];

    return _buildDropdownField(
      context,
      label: 'Experience Level',
      icon: Icons.trending_up,
      items: levels,
      validator: (value) =>
          value == null ? 'Please select your experience level' : null,
    );
  }

  Widget _buildInterestsField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Areas of Interest',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _buildInterestChips(context),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildInterestChips(BuildContext context) {
    final interests = [
      'Web Development',
      'Mobile Development',
      'UI/UX Design',
      'Data Science',
      'Machine Learning',
      'Digital Marketing',
      'Business',
      'Photography',
      'Music',
      'Language Learning'
    ];

    return interests.map((interest) {
      return Obx(() {
        final isSelected = selectedInterests.contains(interest);
        return FilterChip(
          label: Text(interest),
          selected: isSelected,
          onSelected: (selected) {
            if (selected) {
              selectedInterests.add(interest);
            } else {
              selectedInterests.remove(interest);
            }
          },
          selectedColor: AppColors.primaryColor.withOpacity(0.2),
          checkmarkColor: AppColors.primaryColor,
        );
      });
    }).toList();
  }

  Widget _buildLearningGoals(BuildContext context) {
    return _buildInputField(
      context,
      label: 'Learning Goals',
      icon: Icons.flag_outlined,
      maxLines: 3,
      validator: (value) =>
          value?.isEmpty ?? true ? 'Please share your learning goals' : null,
    );
  }

  Widget _buildDropdownField(
    BuildContext context, {
    required String label,
    required IconData icon,
    required List<String> items,
    required String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppColors.primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Theme.of(context).cardColor,
          labelStyle: TextStyle(color: AppColors.textSecondaryColor),
          floatingLabelStyle: TextStyle(color: AppColors.primaryColor),
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (_) {},
        validator: validator,
      ),
    );
  }
}
